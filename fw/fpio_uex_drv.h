/****************************************************************************
 * fpio_uex_drv.h
 ****************************************************************************/
#ifndef INCLUDED_FPIO_UEX_DRV_H
#define INCLUDED_FPIO_UEX_DRV_H
#include <stdint.h>

typedef struct fpio_uex_drv_s {
	uint32_t		*base;

} fpio_uex_drv_t;

#ifdef __cplusplus
extern "C" {
#endif

void fpio_uex_drv_init(
		fpio_uex_drv_t		*drv,
		void				*base);

int fpio_uex_drv_write(
		fpio_uex_drv_t		*drv,
		void				*data,
		uint32_t			sz);

int fpio_uex_drv_read(
		fpio_uex_drv_t		*drv,
		void				*data,
		uint32_t			sz);

#ifdef __cplusplus
}
#endif

#endif /* INCLUDED_FPIO_UEX_DRV_H */
