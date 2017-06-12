/****************************************************************************
 * fpio_uex_drv.c
 ****************************************************************************/
#include "fpio_uex_drv.h"
#include "uex.h"
#include <string.h>
#include <stdio.h>

void fpio_uex_drv_init(
		fpio_uex_drv_t		*drv,
		void				*base) {
	int i;

	memset(drv, 0, sizeof(fpio_uex_drv_t));

	drv->base = (uint32_t *)uex_ioremap(base, 64, 0);

	for (i=0; i<16; i++) {
		fpio_uex_drv_write(drv, &i, 1);
	}
}

int fpio_uex_drv_write(
		fpio_uex_drv_t		*drv,
		void				*data,
		uint32_t			sz) {
	uint32_t avail;
	uint32_t i;

	uint8_t *data_p = (uint8_t *)data;
	do {
		avail = uex_ioread32(drv->base+1);
		fprintf(stdout, "avail=%d\n", avail);
	} while (avail == 0);

	for (i=0; i<sz; i++) {
		uex_iowrite8(data_p[i], drv->base);
	}

	return (i+1);
}

int fpio_uex_drv_read(
		fpio_uex_drv_t		*drv,
		void				*data,
		uint32_t			sz) {

}
