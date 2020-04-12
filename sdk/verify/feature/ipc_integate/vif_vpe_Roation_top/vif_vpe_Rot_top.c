/* Copyright (c) 2018-2019 Sigmastar Technology Corp.
 All rights reserved.
  
  Unless otherwise stipulated in writing, any and all information contained
 herein regardless in any format shall remain the sole proprietary of
 Sigmastar Technology Corp. and be kept in strict confidence
 (��Sigmastar Confidential Information��) by the recipient.
 Any unauthorized act including without limitation unauthorized disclosure,
 copying, use, reproduction, sale, distribution, modification, disassembling,
 reverse engineering and compiling of the contents of Sigmastar Confidential
 Information is unlawful and strictly prohibited. Sigmastar hereby reserves the
 rights to any and all damages, losses, costs and expenses resulting therefrom.
*/
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <pthread.h>
#include <sys/prctl.h>
#include <poll.h>
#include <fcntl.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/resource.h>
#include<sys/mman.h>
#include<sys/types.h>
#include<sys/stat.h>
#include "mi_sys.h"
#include "../common/st_common.h"
#include "../common/st_vpe.h"
#include "../common/st_vif.h"
#define BUFNUM 10
#ifndef ASSERT
#define ASSERT(_x_)                                                                         \
    do  {                                                                                   \
        if ( ! ( _x_ ) )                                                                    \
        {                                                                                   \
            printf("ASSERT FAIL: %s %s %d\n", __FILE__, __PRETTY_FUNCTION__, __LINE__);     \
            abort();                                                                        \
        }                                                                                   \
    } while (0)
#endif

typedef struct Test_Parames_s
{
    int cnt;
    const char *pDestFile;
    MI_U16 u16Width;
    MI_U16 u16Height;
    MI_U16 u16PortId ;
    MI_SYS_PixelFormat_e ePixelFormat;
    MI_BOOL bRot;
    int sd;
}Test_Parames_t;

static MI_S32 St_WriteFile(Test_Parames_t     *pstParamer)
{
    MI_SYS_ChnPort_t stVpeChnOutputPort;
    MI_SYS_BufInfo_t stBufInfo;
    MI_SYS_BufConf_t stBufConf;
    MI_SYS_BUF_HANDLE hHandle;
    MI_U16  u16BufInfoStride =0;
    MI_U16  u16BufInfoHeight =0;
    MI_U32  u32FrameSize =0;
    int offset =0;
    MI_U8 u8BufNum = BUFNUM;

    if(pstParamer->cnt > u8BufNum)
        pstParamer->cnt = u8BufNum;

    stVpeChnOutputPort.eModId = E_MI_MODULE_ID_VPE;
    stVpeChnOutputPort.u32DevId = 0;
    stVpeChnOutputPort.u32ChnId = 0;
    stVpeChnOutputPort.u32PortId = pstParamer->u16PortId;

    stBufConf.eBufType = E_MI_SYS_BUFDATA_FRAME;
    stBufConf.u64TargetPts = 0x1234;
    stBufConf.stFrameCfg.eFormat = pstParamer->ePixelFormat;
    stBufConf.stFrameCfg.eFrameScanMode = E_MI_SYS_FRAME_SCAN_MODE_PROGRESSIVE;
    stBufConf.stFrameCfg.u16Width = pstParamer->u16Width;
    stBufConf.stFrameCfg.u16Height = pstParamer->u16Height;

    do{
        if (MI_SUCCESS == MI_SYS_ChnOutputPortGetBuf(&stVpeChnOutputPort , &stBufInfo,&hHandle))
        {
            // Add user write buffer to file
            u16BufInfoStride  = stBufInfo.stFrameData.u32Stride[0];
            u16BufInfoHeight = stBufInfo.stFrameData.u16Height;
            u32FrameSize = u16BufInfoStride*u16BufInfoHeight;
            // put frame
            printf("getbuf sucess, size(%dx%d), stride(%d, %d, %d), Pixel %d, viraddr(%p, %p, %p)\n", stBufInfo.stFrameData.u16Width, stBufInfo.stFrameData.u16Height,
            stBufInfo.stFrameData.u32Stride[0], stBufInfo.stFrameData.u32Stride[1], stBufInfo.stFrameData.u32Stride[2], stBufInfo.stFrameData.ePixelFormat,
            stBufInfo.stFrameData.pVirAddr[0], stBufInfo.stFrameData.pVirAddr[1], stBufInfo.stFrameData.pVirAddr[2]);

            if(pstParamer->cnt >= u8BufNum)
            {
                printf("begin write file\n");
                STCHECKRESULT(ST_Write_OneFrame(pstParamer->sd, offset, stBufInfo.stFrameData.pVirAddr[0], u16BufInfoStride, u16BufInfoStride, u16BufInfoHeight));
                offset += u32FrameSize;

                if(pstParamer->ePixelFormat == E_MI_SYS_PIXEL_FRAME_YUV_SEMIPLANAR_420)
                {
                    STCHECKRESULT(ST_Write_OneFrame(pstParamer->sd, offset, stBufInfo.stFrameData.pVirAddr[1], u16BufInfoStride, u16BufInfoStride, u16BufInfoHeight/2));
                    offset += u32FrameSize/2;
                }
            }
            STCHECKRESULT(MI_SYS_ChnOutputPortPutBuf(hHandle));
            printf("put buf %d done\n", u8BufNum);
            u8BufNum--;
        }
    }while(u8BufNum > 0);

    return MI_SUCCESS;
}

static MI_S32 St_BaseModuleInit(Test_Parames_t     *pstParamer)
{
    MI_SYS_ChnPort_t stChnPort;
    ST_Sys_BindInfo_t stBindInfo;
    ST_VIF_PortInfo_t stVifPortInfoInfo;
    ST_VPE_ChannelInfo_t stVpeChannelInfo;
    ST_VPE_PortInfo_t stPortInfo;

    memset(&stChnPort, 0x0, sizeof(MI_SYS_ChnPort_t));
    memset(&stBindInfo, 0x0, sizeof(ST_Sys_BindInfo_t));
    memset(&stVifPortInfoInfo, 0x0, sizeof(ST_VIF_PortInfo_t));
    memset(&stVpeChannelInfo, 0x0, sizeof(ST_VPE_ChannelInfo_t));
    memset(&stPortInfo, 0x0, sizeof(ST_VPE_PortInfo_t));

    STCHECKRESULT(ST_Sys_Init());
    STCHECKRESULT(ST_Vif_CreateDev(0, SAMPLE_VI_MODE_MIPI_1_1080P_REALTIME));
    stVifPortInfoInfo.u32RectX = 0;
    stVifPortInfoInfo.u32RectY = 0;
    stVifPortInfoInfo.u32RectWidth = 1920;
    stVifPortInfoInfo.u32RectHeight = 1080;
    stVifPortInfoInfo.u32DestWidth = 1920;
    stVifPortInfoInfo.u32DestHeight = 1080;
    stVifPortInfoInfo.ePixFormat = E_MI_SYS_PIXEL_FRAME_RGB_BAYER_12BPP_RG;
    STCHECKRESULT(ST_Vif_CreatePort(0, 0, &stVifPortInfoInfo));
    STCHECKRESULT(ST_Vif_StartPort(0, 0));
    printf("vif port(%dx%d), pixel %d\n", stVifPortInfoInfo.u32DestWidth, stVifPortInfoInfo.u32DestHeight, stVifPortInfoInfo.ePixFormat);
    /************************************************
    Step4:  init VPE top
    *************************************************/
    stVpeChannelInfo.u16VpeMaxW = 1920;
    stVpeChannelInfo.u16VpeMaxH = 1080;
    stVpeChannelInfo.u32X = 0;
    stVpeChannelInfo.u32Y = 0;
    stVpeChannelInfo.u16VpeCropW = 0;
    stVpeChannelInfo.u16VpeCropH = 0;
    stVpeChannelInfo.eRunningMode = E_MI_VPE_RUN_REALTIME_TOP_MODE;
    stVpeChannelInfo.bRot = pstParamer->bRot;
    stVpeChannelInfo.eFormat = E_MI_SYS_PIXEL_FRAME_RGB_BAYER_12BPP_RG;
    STCHECKRESULT(ST_Vpe_CreateChannel(0, &stVpeChannelInfo));
    STCHECKRESULT(ST_Vpe_StartChannel(0));
    stPortInfo.DepVpeChannel = 0;
    stPortInfo.ePixelFormat = pstParamer->ePixelFormat;
    stPortInfo.u16OutputWidth = 1920;
    stPortInfo.u16OutputHeight = 1080;
    STCHECKRESULT(ST_Vpe_CreatePort(0, &stPortInfo)); //default support port0 --->>> vdisp
    printf("vpeTOP port%d, (%dx%d), pixel %d, runmode %d\n", 0, stPortInfo.u16OutputWidth,
        stPortInfo.u16OutputHeight, stPortInfo.ePixelFormat, stVpeChannelInfo.eRunningMode);

    stChnPort.eModId = E_MI_MODULE_ID_VPE;
    stChnPort.u32DevId = 0;
    stChnPort.u32ChnId = 0;
    stChnPort.u32PortId = pstParamer->u16PortId;
    MI_SYS_SetChnOutputPortDepth(&stChnPort, 2, 5);
    printf("depth portid %d\n", pstParamer->u16PortId);

    /************************************************
    Step7:  Bind VIF->VPE top
    *************************************************/
    memset(&stBindInfo, 0x0, sizeof(ST_Sys_BindInfo_t));
    stBindInfo.stSrcChnPort.eModId = E_MI_MODULE_ID_VIF;
    stBindInfo.stSrcChnPort.u32DevId = 0; //VIF dev == 0
    stBindInfo.stSrcChnPort.u32ChnId = 0;
    stBindInfo.stSrcChnPort.u32PortId = 0; //Main stream
    stBindInfo.stDstChnPort.eModId = E_MI_MODULE_ID_VPE;
    stBindInfo.stDstChnPort.u32DevId = 0;
    stBindInfo.stDstChnPort.u32ChnId = 0;
    stBindInfo.stDstChnPort.u32PortId = 0;
    stBindInfo.u32SrcFrmrate = 30;
    stBindInfo.u32DstFrmrate = 30;
    STCHECKRESULT(ST_Sys_Bind(&stBindInfo));

    return MI_SUCCESS;
}

static MI_S32 St_BaseModuleDeinit(Test_Parames_t     * pstParamer)
{
    ST_Sys_BindInfo_t stBindInfo;
    memset(&stBindInfo, 0x0, sizeof(ST_Sys_BindInfo_t));
    stBindInfo.stSrcChnPort.eModId = E_MI_MODULE_ID_VIF;
    stBindInfo.stSrcChnPort.u32DevId = 0; //VIF dev == 0
    stBindInfo.stSrcChnPort.u32ChnId = 0;
    stBindInfo.stSrcChnPort.u32PortId = 0; //Main stream
    stBindInfo.stDstChnPort.eModId = E_MI_MODULE_ID_VPE;
    stBindInfo.stDstChnPort.u32DevId = 0;
    stBindInfo.stDstChnPort.u32ChnId = 0;
    stBindInfo.stDstChnPort.u32PortId = 0;
    stBindInfo.u32SrcFrmrate = 30;
    stBindInfo.u32DstFrmrate = 30;
    STCHECKRESULT(ST_Sys_UnBind(&stBindInfo));

    STCHECKRESULT(ST_Vpe_StopPort(0, pstParamer->u16PortId));
    STCHECKRESULT(ST_Vpe_StopChannel(0));
    STCHECKRESULT(ST_Vpe_DestroyChannel(0));
    STCHECKRESULT(ST_Vif_StopPort(0, 0));
    STCHECKRESULT(ST_Vif_DisableDev(0));
    STCHECKRESULT(ST_Sys_Exit());
    return MI_SUCCESS;
}

int checkParame(Test_Parames_t     *pstParamer)
{
    int cnt =pstParamer->cnt;
    const char *pDestFile = pstParamer->pDestFile;
    MI_U16 u16Width=pstParamer->u16Width, u16Height=pstParamer->u16Height, u16PortId =pstParamer->u16PortId;
    MI_SYS_PixelFormat_e ePixelFormat = pstParamer->ePixelFormat;
    MI_BOOL bRot = pstParamer->bRot;

    if(u16PortId <0 || u16PortId > 3)
    {
        printf("portid %d err\n", u16PortId);
        return 1;
    }

    if(u16Width < 0 || u16Width > 1920 || u16Height < 0 || u16Height > 1080)
    {
        printf("width %d, height %d err \n", u16Width, u16Height);
        return 1;
    }

    if(ePixelFormat != E_MI_SYS_PIXEL_FRAME_YUV422_YUYV
        && ePixelFormat != E_MI_SYS_PIXEL_FRAME_YUV_SEMIPLANAR_420
        && ePixelFormat !=E_MI_SYS_PIXEL_FRAME_ARGB8888
        && ePixelFormat !=E_MI_SYS_PIXEL_FRAME_ABGR8888
        && ePixelFormat !=E_MI_SYS_PIXEL_FRAME_BGRA8888)
    {
        printf("pixel %d err \n", ePixelFormat);
        return 1;
    }

    if(bRot > 1)
    {
        printf("bRot %d err \n", bRot);
        pstParamer->bRot = TRUE;
    }

    if(pDestFile == NULL || cnt ==0)
    {
        printf("destfill is %p, cnt %d \n", pDestFile, cnt);
        return 1;
    }

    return MI_SUCCESS;
}

MI_S32 main(int argc, char **argv)
{
    Test_Parames_t  stParamer;
    memset(&stParamer, 0x0, sizeof(Test_Parames_t));

    if(argc < 5)
    {
       printf("paramer cnt %d < 5 \n", argc);
       printf("pixel[1](YUV422:0, YUV420:10, ARGB8888:1, BGRA8888:3),brot[2] filepath[3], cnt[4]\n");
       return 1;
    }

    stParamer.ePixelFormat = atoi(argv[1]);
    stParamer.bRot = atoi(argv[2]);
    stParamer.pDestFile = argv[3];
    stParamer.cnt = atoi(argv[4]);

    printf("pixel %d, Rot %d, filename %s, cnt %d\n", stParamer.u16PortId,
        stParamer.u16Width, stParamer.u16Height,stParamer.ePixelFormat, stParamer.bRot, stParamer.pDestFile,stParamer.cnt);

    stParamer.u16PortId = 0;
    stParamer.u16Width = 1920;
    stParamer.u16Height = 1080;

    STCHECKRESULT(checkParame(&stParamer));
    STCHECKRESULT(ST_OpenDestFile(stParamer.pDestFile, &stParamer.sd));
    STCHECKRESULT(St_BaseModuleInit(&stParamer));

    STCHECKRESULT(St_WriteFile(&stParamer));
    //STCHECKRESULT(St_BaseModuleDeinit(&stParamer));
    return 0;
}