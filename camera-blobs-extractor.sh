#!/bin/bash

# Sultan camera HAL blobs
SULTAN_LIBS=" \
vendor/lib/libjpegdhw.so
vendor/lib/libjpegehw.so
vendor/lib/libmmcamera2_c2d_module.so
vendor/lib/libmmcamera2_cpp_module.so
vendor/lib/libmmcamera2_frame_algorithm.so
vendor/lib/libmmcamera2_iface_modules.so
vendor/lib/libmmcamera2_imglib_modules.so
vendor/lib/libmmcamera2_is.so
vendor/lib/libmmcamera2_isp_modules.so
vendor/lib/libmmcamera2_pproc_modules.so
vendor/lib/libmmcamera2_q3a_core.so
vendor/lib/libmmcamera2_sensor_modules.so
vendor/lib/libmmcamera2_stats_algorithm.so
vendor/lib/libmmcamera2_stats_modules.so
vendor/lib/libmmcamera2_vpe_module.so
vendor/lib/libmmcamera2_wnr_module.so
vendor/lib/libmmcamera_cac_lib.so
vendor/lib/libmmcamera_faceproc.so
vendor/lib/libmmcamera_hdr_gb_lib.so
vendor/lib/libmmcamera_hdr_lib.so
vendor/lib/libmmcamera_imglib.so
vendor/lib/libmmcamera_ov8858.so
vendor/lib/libmmcamera_pdaf.so
vendor/lib/libmmcamera_pdafcamif.so
vendor/lib/libmmcamera_s5k3m2.so
vendor/lib/libmmcamera_sunny_f13s01l_eeprom.so
vendor/lib/libmmcamera_sunny_p8v12b_eeprom.so
vendor/lib/libmmcamera_tintless_algo.so
vendor/lib/libmmcamera_tintless_bg_pca_algo.so
vendor/lib/libmmcamera_wavelet_lib.so
vendor/lib/libmmipl.so
vendor/lib/libmmjpeg.so
vendor/lib/libmmqjpeg_codec.so
vendor/lib/liboemcamera.so
vendor/lib/libqomx_jpegdec.so
vendor/lib/libqomx_jpegenc.so
vendor/lib/libactuator_dw9800w.so
vendor/lib/libactuator_dw9800w_camcorder.so
vendor/lib/libactuator_dw9800w_camera.so
vendor/lib/libchromatix_ov8858_common.so
vendor/lib/libchromatix_ov8858_default_video.so
vendor/lib/libchromatix_ov8858_liveshot.so
vendor/lib/libchromatix_ov8858_preview.so
vendor/lib/libchromatix_ov8858_preview_binding.so
vendor/lib/libchromatix_ov8858_small_video.so
vendor/lib/libchromatix_ov8858_snapshot.so
vendor/lib/libchromatix_s5k3m2_common.so
vendor/lib/libchromatix_s5k3m2_default_video.so
vendor/lib/libchromatix_s5k3m2_hfr_120fps.so
vendor/lib/libchromatix_s5k3m2_hfr_60fps.so
vendor/lib/libchromatix_s5k3m2_hfr_90fps.so
vendor/lib/libchromatix_s5k3m2_liveshot.so
vendor/lib/libchromatix_s5k3m2_preview.so
vendor/lib/libchromatix_s5k3m2_snapshot.so
vendor/lib/libchromatix_s5k3m2_zsl.so"

# OOS3 camera HAL blobs
OOS3_LIBS="\
vendor/lib/libFNVfbEngineLib.so
vendor/lib/libopcamerahw_interface.so
vendor/lib/libjpegdhw.so
vendor/lib/libjpegehw.so
vendor/lib/libmmcamera2_c2d_module.so
vendor/lib/libmmcamera2_cpp_module.so
vendor/lib/libmmcamera2_frame_algorithm.so
vendor/lib/libmmcamera2_iface_modules.so
vendor/lib/libmmcamera2_imglib_modules.so
vendor/lib/libmmcamera2_is.so
vendor/lib/libmmcamera2_isp_modules.so
vendor/lib/libmmcamera2_pproc_modules.so
vendor/lib/libmmcamera2_q3a_core.so
vendor/lib/libmmcamera2_sensor_modules.so
vendor/lib/libmmcamera2_stats_algorithm.so
vendor/lib/libmmcamera2_stats_modules.so
vendor/lib/libmmcamera2_vpe_module.so
vendor/lib/libmmcamera2_wnr_module.so
vendor/lib/libmmcamera_cac_lib.so
vendor/lib/libmmcamera_dw9761b_eeprom.so
vendor/lib/libmmcamera_faceproc.so
vendor/lib/libmmcamera_hdr_gb_lib.so
vendor/lib/libmmcamera_hdr_lib.so
vendor/lib/libmmcamera_imglib.so
vendor/lib/libmmcamera_imx214.so
vendor/lib/libmmcamera_ofilm_oty5f03_eeprom.so
vendor/lib/libmmcamera_ov5648.so
vendor/lib/libmmcamera_ov8858.so
vendor/lib/libmmcamera_pdaf.so
vendor/lib/libmmcamera_pdafcamif.so
vendor/lib/libmmcamera_s5k3l8.so
vendor/lib/libmmcamera_s5k3m2.so
vendor/lib/libmmcamera_sunny_f13s01l_eeprom.so
vendor/lib/libmmcamera_sunny_p12v01m_eeprom.so
vendor/lib/libmmcamera_sunny_p5v23c_eeprom.so
vendor/lib/libmmcamera_sunny_p8v12b_eeprom.so
vendor/lib/libmmcamera_sunny_q8v18a_eeprom.so
vendor/lib/libmmcamera_tintless_algo.so
vendor/lib/libmmcamera_tintless_bg_pca_algo.so
vendor/lib/libmmcamera_truly_cm7700_eeprom.so
vendor/lib/libmmcamera_wavelet_lib.so
vendor/lib/libmmipl.so
vendor/lib/libmmjpeg.so
vendor/lib/libmmqjpeg_codec.so
vendor/lib/liboemcamera.so
vendor/lib/libqomx_jpegdec.so
vendor/lib/libqomx_jpegenc.so
vendor/lib/libactuator_dw9714.so
vendor/lib/libactuator_dw9714_camcorder.so
vendor/lib/libactuator_dw9714_camera.so
vendor/lib/libactuator_dw9800w.so
vendor/lib/libactuator_dw9800w_camcorder.so
vendor/lib/libactuator_dw9800w_camera.so
vendor/lib/libchromatix_ov8858_common.so
vendor/lib/libchromatix_ov8858_default_video.so
vendor/lib/libchromatix_ov8858_liveshot.so
vendor/lib/libchromatix_ov8858_preview.so
vendor/lib/libchromatix_ov8858_preview_binding.so
vendor/lib/libchromatix_ov8858_small_video.so
vendor/lib/libchromatix_ov8858_snapshot.so
vendor/lib/libchromatix_s5k3m2_common.so
vendor/lib/libchromatix_s5k3m2_common_panorama.so
vendor/lib/libchromatix_s5k3m2_default_video.so
vendor/lib/libchromatix_s5k3m2_hfr_120fps.so
vendor/lib/libchromatix_s5k3m2_hfr_60fps.so
vendor/lib/libchromatix_s5k3m2_hfr_90fps.so
vendor/lib/libchromatix_s5k3m2_liveshot.so
vendor/lib/libchromatix_s5k3m2_preview.so
vendor/lib/libchromatix_s5k3m2_preview_panorama.so
vendor/lib/libchromatix_s5k3m2_snapshot.so
vendor/lib/libchromatix_s5k3m2_snapshot_panorama.so
vendor/lib/libchromatix_s5k3m2_video_hd.so
vendor/lib/libchromatix_s5k3m2_zsl.so"

ROOT_DIR="/home/ikke/Work/proprietary_vendor_oneplus_tmp/"
OOS3_URL="https://raw.githubusercontent.com/YumeMichi/proprietary_vendor_oneplus/o-mr1/"
SULTAN_URL="https://raw.githubusercontent.com/YumeMichi/proprietary_vendor_oneplus/lineage-15.1-sultan/"

SULTAN_LIBS=(${SULTAN_LIBS})
SULTAN_BLOBS=${SULTAN_LIBS[@]}

OOS3_LIBS=(${OOS3_LIBS})
OOS3_BLOBS=${OOS3_LIBS[@]}

SyncCameraHAL() {
	TEMP1=$1
	TEMP2=$2
	MODE=$3
	FLAG=1

	for b in ${TEMP1[@]}
	do
		BLOB=${b//\//\\\/}
		echo -e "Deleting...\t"${b}

		FILE=${ROOT_DIR}"onyx/proprietary/"${b}
		if [ -f "$FILE" ]; then
			rm -rf $FILE
			sed "/${BLOB}/d" -i ${ROOT_DIR}"onyx/onyx-vendor.mk"
		else
			echo "Error: $FILE not found! Cleaning up vendor tree..."
			cd $ROOT_DIR
			git reset --hard > /dev/null && git clean -f -d
			FLAG=0
			break
		fi
	done

	if [[ "$FLAG" == "0" ]]; then
		exit
	fi

	for b in ${TEMP2[@]}
	do
		BLOB=${b//\//\\\/}
		echo -e "Processing...\t"${b}
		if [[ "$MODE" == "1" ]]; then
			URL=${SULTAN_URL}
		else
			URL=${OOS3_URL}
		fi
		echo -e "Downloading...\t"${URL}"onyx/proprietary/"${b}
		FILE=${ROOT_DIR}"onyx/proprietary/"${b}
		wget -qO $FILE ${URL}"onyx/proprietary/"${b}
		if [[ ! -f "$FILE" ]]; then
			echo -e "Error: Download $FILE failed! Cleaning up vendor tree..."
			cd $ROOT_DIR
			git reset --hard > /dev/null && git clean -f -d
			break
		fi
		# TODO
		# Insert new lines into onyx-vendor.mk automatically.
	done
}

# 1: Replace OOS3 camera HAL with Sultan camera HAL
# 2: Replace Sultan camera HAL with OOS3 camera HAL
MODE=$1
if [[ "$MODE" == "1" ]]; then
	SyncCameraHAL "$OOS3_BLOBS" "$SULTAN_BLOBS" "$MODE"
elif [[ "$MODE" == "2" ]]; then
	SyncCameraHAL "$SULTAN_BLOBS" "$OOS3_BLOBS" "$MODE"
else
	echo "Invalid parameter!"
fi
