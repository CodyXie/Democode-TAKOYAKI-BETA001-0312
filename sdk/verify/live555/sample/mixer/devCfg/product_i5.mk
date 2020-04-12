PRODUCTID ?= 1

M_VENC_BIND_TYPE ?= 0
S_VENC_BIND_TYPE ?= 0
T_VENC_BIND_TYPE ?= 0
J_VENC_BIND_TYPE ?= 0
O_VENC_BIND_TYPE ?= 0

M_STREAM_FROM_PORT ?= 1
S_STREAM_FROM_PORT ?= 2
T_STREAM_FROM_PORT ?= 2
J_STREAM_FROM_PORT ?= 0
O_STREAM_FROM_PORT ?= 2

M_STREAM_MAX_BITRATE ?= 16000000
M_STREAM_MIN_BITRATE ?= 512000
M_STREAM_CUR_BITRATE ?= 2000000

S_STREAM_MAX_BITRATE ?= 4000000
S_STREAM_MIN_BITRATE ?= 128000
S_STREAM_CUR_BITRATE ?= 1000000

T_STREAM_MAX_BITRATE ?= 4000000
T_STREAM_MIN_BITRATE ?= 128000
T_STREAM_CUR_BITRATE ?= 768000

O_STREAM_MAX_BITRATE ?= 4000000
O_STREAM_MIN_BITRATE ?= 128000
O_STREAM_CUR_BITRATE ?= 768000

J_STREAM_MAX_BITRATE ?= 4000000
J_STREAM_MIN_BITRATE ?= 512000
J_STREAM_CUR_BITRATE ?= 2000000

ifeq ($(PRODUCTID),	0)
_3DNR_LEVEL ?= 1
VPE_OUTPORT0_W ?= 1440
VPE_OUTPORT0_H ?= 1440

VPE_OUTPORT1_W ?= 1440
VPE_OUTPORT1_H ?= 1440

VPE_OUTPORT2_W ?= 720
VPE_OUTPORT2_H ?= 720

MAIN_STREAM_MAX_W ?= 1440
MAIN_STREAM_MAX_H ?= 1440

SECOND_STREAM_MAX_W ?= 1200
SECOND_STREAM_MAX_H ?= 1200

THIRD_STREAM_MAX_W ?= 720
THIRD_STREAM_MAX_H ?= 720

MAIN_STREAM_W ?= 1440
MAIN_STREAM_H ?= 1440

SECOND_STREAM_W ?= 1200
SECOND_STREAM_H ?= 1200

JPG_STREAM_W ?= 1920
JPG_STREAM_H ?= 1080

THIRD_STREAM_W ?= 720
THIRD_STREAM_H ?= 720

else ifeq ($(PRODUCTID), 1)
_3DNR_LEVEL ?= 1
VPE_OUTPORT0_W ?= 1920
VPE_OUTPORT0_H ?= 1080

VPE_OUTPORT1_W ?= 1920
VPE_OUTPORT1_H ?= 1080

VPE_OUTPORT2_W ?= 1280
VPE_OUTPORT2_H ?= 720

MAIN_STREAM_MAX_W ?= 1920
MAIN_STREAM_MAX_H ?= 1080

SECOND_STREAM_MAX_W ?= 1280
SECOND_STREAM_MAX_H ?= 720

THIRD_STREAM_MAX_W ?= 704
THIRD_STREAM_MAX_H ?= 576

MAIN_STREAM_W ?= 1920
MAIN_STREAM_H ?= 1080

SECOND_STREAM_W ?= 1280
SECOND_STREAM_H ?= 720

THIRD_STREAM_W ?= 704
THIRD_STREAM_H ?= 576

else ifeq ($(PRODUCTID), 2)
_3DNR_LEVEL ?= 1
VPE_OUTPORT0_W ?= 2048
VPE_OUTPORT0_H ?= 1536

VPE_OUTPORT1_W ?= 2048
VPE_OUTPORT1_H ?= 1536

VPE_OUTPORT2_W ?= 1280
VPE_OUTPORT2_H ?= 720

MAIN_STREAM_MAX_W ?= 2048
MAIN_STREAM_MAX_H ?= 1536

SECOND_STREAM_MAX_W ?= 1920
SECOND_STREAM_MAX_H ?= 1080

THIRD_STREAM_MAX_W ?= 1280
THIRD_STREAM_MAX_H ?= 720

MAIN_STREAM_W ?= 2048
MAIN_STREAM_H ?= 1536

SECOND_STREAM_W ?= 1920
SECOND_STREAM_H ?= 1080

THIRD_STREAM_W ?= 1280
THIRD_STREAM_H ?= 720

else ifeq ($(PRODUCTID), 3)
_3DNR_LEVEL ?= 1
VPE_OUTPORT0_W ?= 2304
VPE_OUTPORT0_H ?= 1296

VPE_OUTPORT1_W ?= 2304
VPE_OUTPORT1_H ?= 1296

VPE_OUTPORT2_W ?= 1920
VPE_OUTPORT2_H ?= 1080

MAIN_STREAM_MAX_W ?= 2304
MAIN_STREAM_MAX_H ?= 1926

SECOND_STREAM_MAX_W ?= 1920
SECOND_STREAM_MAX_H ?= 1080

THIRD_STREAM_MAX_W ?= 1280
THIRD_STREAM_MAX_H ?= 720

MAIN_STREAM_W ?= 2304
MAIN_STREAM_H ?= 1926

SECOND_STREAM_W ?= 1920
SECOND_STREAM_H ?= 1080

THIRD_STREAM_W ?= 1280
THIRD_STREAM_H ?= 720

else ifeq ($(PRODUCTID), 4)
_3DNR_LEVEL ?= 1
VPE_OUTPORT0_W ?= 2560
VPE_OUTPORT0_H ?= 1440

VPE_OUTPORT1_W ?= 2560
VPE_OUTPORT1_H ?= 1440

VPE_OUTPORT2_W ?= 1920
VPE_OUTPORT2_H ?= 1080

MAIN_STREAM_MAX_W ?= 2560
MAIN_STREAM_MAX_H ?= 1440

SECOND_STREAM_MAX_W ?= 1920
SECOND_STREAM_MAX_H ?= 1080

THIRD_STREAM_MAX_W ?= 1280
THIRD_STREAM_MAX_H ?= 720

MAIN_STREAM_W ?= 2560
MAIN_STREAM_H ?= 1440

SECOND_STREAM_W ?= 1920
SECOND_STREAM_H ?= 1080

THIRD_STREAM_W ?= 1280
THIRD_STREAM_H ?= 720

else ifeq ($(PRODUCTID), 5)
_3DNR_LEVEL ?= 1
VPE_OUTPORT0_W ?= 2560
VPE_OUTPORT0_H ?= 1536

VPE_OUTPORT1_W ?= 2560
VPE_OUTPORT1_H ?= 1530

VPE_OUTPORT2_W ?= 1280
VPE_OUTPORT2_H ?= 720

MAIN_STREAM_MAX_W ?= 2560
MAIN_STREAM_MAX_H ?= 1536

SECOND_STREAM_MAX_W ?= 1920
SECOND_STREAM_MAX_H ?= 1080

THIRD_STREAM_MAX_W ?= 1280
THIRD_STREAM_MAX_H ?= 720

MAIN_STREAM_W ?= 2560
MAIN_STREAM_H ?= 1536

SECOND_STREAM_W ?= 1920
SECOND_STREAM_H ?= 1080

THIRD_STREAM_W ?= 1280
THIRD_STREAM_H ?= 720

else ifeq ($(PRODUCTID), 6)
_3DNR_LEVEL ?= 1
VPE_OUTPORT0_W ?= 2688
VPE_OUTPORT0_H ?= 1536

VPE_OUTPORT1_W ?= 2688
VPE_OUTPORT1_H ?= 1536

VPE_OUTPORT2_W ?= 1920
VPE_OUTPORT2_H ?= 1080

MAIN_STREAM_MAX_W ?= 2688
MAIN_STREAM_MAX_H ?= 1536

SECOND_STREAM_MAX_W ?= 1920
SECOND_STREAM_MAX_H ?= 1080

THIRD_STREAM_MAX_W ?= 1280
THIRD_STREAM_MAX_H ?= 720

MAIN_STREAM_W ?= 2688
MAIN_STREAM_H ?= 1536

SECOND_STREAM_W ?= 1920
SECOND_STREAM_H ?= 1080

THIRD_STREAM_W ?= 1280
THIRD_STREAM_H ?= 720

else ifeq ($(PRODUCTID), 7)
_3DNR_LEVEL ?= 1
VPE_OUTPORT0_W ?= 2952
VPE_OUTPORT0_H ?= 1944

VPE_OUTPORT1_W ?= 2952
VPE_OUTPORT1_H ?= 1944

VPE_OUTPORT2_W ?= 1920
VPE_OUTPORT2_H ?= 1080

MAIN_STREAM_MAX_W ?= 2952
MAIN_STREAM_MAX_H ?= 1944

SECOND_STREAM_MAX_W ?= 1920
SECOND_STREAM_MAX_H ?= 1080

THIRD_STREAM_MAX_W ?= 1280
THIRD_STREAM_MAX_H ?= 720

MAIN_STREAM_W ?= 2952
MAIN_STREAM_H ?= 1944

SECOND_STREAM_W ?= 1920
SECOND_STREAM_H ?= 1080

THIRD_STREAM_W ?= 1280
THIRD_STREAM_H ?= 720
else ifeq ($(PRODUCTID), 8)
_3DNR_LEVEL ?= 1
VPE_OUTPORT0_W ?= 3072
VPE_OUTPORT0_H ?= 2160

VPE_OUTPORT1_W ?= 3072
VPE_OUTPORT1_H ?= 2160

VPE_OUTPORT2_W ?= 1920
VPE_OUTPORT2_H ?= 1080

MAIN_STREAM_MAX_W ?= 3072
MAIN_STREAM_MAX_H ?= 2160

SECOND_STREAM_MAX_W ?= 1920
SECOND_STREAM_MAX_H ?= 1080

THIRD_STREAM_MAX_W ?= 1280
THIRD_STREAM_MAX_H ?= 720

MAIN_STREAM_W ?= 3072
MAIN_STREAM_H ?= 2160

SECOND_STREAM_W ?= 1920
SECOND_STREAM_H ?= 1080

THIRD_STREAM_W ?= 1280
THIRD_STREAM_H ?= 720

else ifeq ($(PRODUCTID), 9)
_3DNR_LEVEL ?= 1
VPE_OUTPORT0_W ?= 3840
VPE_OUTPORT0_H ?= 2160

VPE_OUTPORT1_W ?= 3840
VPE_OUTPORT1_H ?= 2160

VPE_OUTPORT2_W ?= 1920
VPE_OUTPORT2_H ?= 1080

MAIN_STREAM_MAX_W ?= 3840
MAIN_STREAM_MAX_H ?= 2160

SECOND_STREAM_MAX_W ?= 1920
SECOND_STREAM_MAX_H ?= 1080

THIRD_STREAM_MAX_W ?= 1280
THIRD_STREAM_MAX_H ?= 720

MAIN_STREAM_W ?= 3840
MAIN_STREAM_H ?= 2160

SECOND_STREAM_W ?= 1920
SECOND_STREAM_H ?= 1080

THIRD_STREAM_W ?= 1280
THIRD_STREAM_H ?= 720
endif
JPEG_STREAM_MAX_W=$(VPE_OUTPORT0_W)
JPEG_STREAM_MAX_H=$(VPE_OUTPORT0_H)

OTHER_VENC_MAX_W=$(VPE_OUTPORT2_W)
OTHER_VENC_MAX_H=$(VPE_OUTPORT2_H)

JPEG_STREAM_W=$(VPE_OUTPORT0_W)
JPEG_STREAM_H=$(VPE_OUTPORT0_H)

OTHER_VENC_W=$(VPE_OUTPORT2_W)
OTHER_VENC_H=$(VPE_OUTPORT2_H)

D_FLAGS += -D _3DNR_LEVEL=$(_3DNR_LEVEL) -D CHIP_ID=\"$(CHIP)\"
D_FLAGS += -D M_VENC_BIND_TYPE=$(M_VENC_BIND_TYPE) -D S_VENC_BIND_TYPE=$(S_VENC_BIND_TYPE) -D T_VENC_BIND_TYPE=$(T_VENC_BIND_TYPE) -D J_VENC_BIND_TYPE=$(J_VENC_BIND_TYPE) 
D_FLAGS += -D O_VENC_BIND_TYPE=$(O_VENC_BIND_TYPE)

D_FLAGS += -D M_STREAM_FROM_PORT=$(M_STREAM_FROM_PORT) -D S_STREAM_FROM_PORT=$(S_STREAM_FROM_PORT) -D T_STREAM_FROM_PORT=$(T_STREAM_FROM_PORT)
D_FLAGS += -D J_STREAM_FROM_PORT=$(J_STREAM_FROM_PORT) -D O_STREAM_FROM_PORT=$(O_STREAM_FROM_PORT)

D_FLAGS += -D M_STREAM_MAX_BITRATE=$(M_STREAM_MAX_BITRATE) -D M_STREAM_MIN_BITRATE=$(M_STREAM_MIN_BITRATE) -D M_STREAM_CUR_BITRATE=$(M_STREAM_CUR_BITRATE)
D_FLAGS += -D S_STREAM_MAX_BITRATE=$(S_STREAM_MAX_BITRATE) -D S_STREAM_MIN_BITRATE=$(S_STREAM_MIN_BITRATE) -D S_STREAM_CUR_BITRATE=$(S_STREAM_CUR_BITRATE)
D_FLAGS += -D T_STREAM_MAX_BITRATE=$(T_STREAM_MAX_BITRATE) -D T_STREAM_MIN_BITRATE=$(T_STREAM_MIN_BITRATE) -D T_STREAM_CUR_BITRATE=$(T_STREAM_CUR_BITRATE)
D_FLAGS += -D O_STREAM_MAX_BITRATE=$(O_STREAM_MAX_BITRATE) -D O_STREAM_MIN_BITRATE=$(O_STREAM_MIN_BITRATE) -D O_STREAM_CUR_BITRATE=$(O_STREAM_CUR_BITRATE)
D_FLAGS += -D J_STREAM_MAX_BITRATE=$(J_STREAM_MAX_BITRATE) -D J_STREAM_MIN_BITRATE=$(J_STREAM_MIN_BITRATE) -D J_STREAM_CUR_BITRATE=$(J_STREAM_CUR_BITRATE)

D_FLAGS += -D VPE_OUTPORT0_W=$(VPE_OUTPORT0_W) -D VPE_OUTPORT0_H=$(VPE_OUTPORT0_H) -D VPE_OUTPORT1_W=$(VPE_OUTPORT1_W)
D_FLAGS += -D VPE_OUTPORT1_H=$(VPE_OUTPORT1_H) -D VPE_OUTPORT2_H=$(VPE_OUTPORT2_H) -D VPE_OUTPORT2_W=$(VPE_OUTPORT2_W)

D_FLAGS += -D MAIN_STREAM_W=$(MAIN_STREAM_W) -D MAIN_STREAM_H=$(MAIN_STREAM_H) -D MAIN_STREAM_MAX_W=$(MAIN_STREAM_MAX_W) -D MAIN_STREAM_MAX_H=$(MAIN_STREAM_MAX_H) 
D_FLAGS += -D SECOND_STREAM_W=$(SECOND_STREAM_W) -D SECOND_STREAM_H=$(SECOND_STREAM_H) -D SECOND_STREAM_MAX_W=$(SECOND_STREAM_MAX_W) -D SECOND_STREAM_MAX_H=$(SECOND_STREAM_MAX_H)
D_FLAGS += -D THIRD_STREAM_W=$(THIRD_STREAM_W) -D THIRD_STREAM_H=$(THIRD_STREAM_H) -D THIRD_STREAM_MAX_W=$(THIRD_STREAM_MAX_W) -D THIRD_STREAM_MAX_H=$(THIRD_STREAM_MAX_H)
D_FLAGS += -D JPEG_STREAM_W=$(JPEG_STREAM_W) -D JPEG_STREAM_H=$(JPEG_STREAM_H) -D JPEG_STREAM_MAX_W=$(JPEG_STREAM_MAX_W) -D JPEG_STREAM_MAX_H=$(JPEG_STREAM_MAX_H)
D_FLAGS += -D OTHER_VENC_W=$(OTHER_VENC_W) -D OTHER_VENC_H=$(OTHER_VENC_H) -D OTHER_VENC_MAX_W=$(OTHER_VENC_MAX_W) -D OTHER_VENC_MAX_H=$(OTHER_VENC_MAX_H)
