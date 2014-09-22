From: Boris BREZILLON <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v5 05/11] drm: add Atmel HLCDC Display Controller support
Date: Mon, 22 Sep 2014 21:18:11 +0200
Message-ID: <20140922211811.11279ff0@bbrezillon>
References: <1410165822-16868-1-git-send-email-boris.brezillon@free-electrons.com>
 <1410165822-16868-6-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1410165822-16868-6-git-send-email-boris.brezillon@free-electrons.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Boris BREZILLON <boris.brezillon@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Pawel Moll <pawel.moll@arm.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Nicolas Ferre <nicolas.ferre@atmel.com>, dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Bo Shen <voice.shen@atmel.com>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Andrew Victor <linux@maxim.org.za>
List-Id: linux-pwm@vger.kernel.org

On Mon,  8 Sep 2014 10:43:36 +0200
Boris BREZILLON <boris.brezillon@free-electrons.com> wrote:

> The Atmel HLCDC (HLCD Controller) IP available on some Atmel SoCs (i.e.
> at91sam9n12, at91sam9x5 family or sama5d3 family) provides a display
> controller device.
> 
> This display controller supports at least one primary plane and might
> provide several overlays and an hardware cursor depending on the IP
> version.
> 
> At the moment, this driver only implements an RGB connector to interface
> with LCD panels, but support for other kind of external devices might be
> added later.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> Tested-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  drivers/gpu/drm/Kconfig                          |   2 +
>  drivers/gpu/drm/Makefile                         |   1 +
>  drivers/gpu/drm/atmel-hlcdc/Kconfig              |  13 +
>  drivers/gpu/drm/atmel-hlcdc/Makefile             |   7 +
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c   | 286 ++++++++
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c     | 488 +++++++++++++
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h     | 224 ++++++
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.c  | 656 ++++++++++++++++++
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.h  | 403 +++++++++++
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 476 +++++++++++++
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c  | 836 +++++++++++++++++++++++
>  11 files changed, 3392 insertions(+)
>  create mode 100644 drivers/gpu/drm/atmel-hlcdc/Kconfig
>  create mode 100644 drivers/gpu/drm/atmel-hlcdc/Makefile
>  create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
>  create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
>  create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
>  create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.c
>  create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.h
>  create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
>  create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index f512004..9183a78 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -184,6 +184,8 @@ source "drivers/gpu/drm/cirrus/Kconfig"
>  
>  source "drivers/gpu/drm/armada/Kconfig"
>  
> +source "drivers/gpu/drm/atmel-hlcdc/Kconfig"
> +
>  source "drivers/gpu/drm/rcar-du/Kconfig"
>  
>  source "drivers/gpu/drm/shmobile/Kconfig"
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index af9a609..07d388c 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -55,6 +55,7 @@ obj-$(CONFIG_DRM_GMA500) += gma500/
>  obj-$(CONFIG_DRM_UDL) += udl/
>  obj-$(CONFIG_DRM_AST) += ast/
>  obj-$(CONFIG_DRM_ARMADA) += armada/
> +obj-$(CONFIG_DRM_ATMEL_HLCDC)	+= atmel-hlcdc/
>  obj-$(CONFIG_DRM_RCAR_DU) += rcar-du/
>  obj-$(CONFIG_DRM_SHMOBILE) +=shmobile/
>  obj-$(CONFIG_DRM_OMAP)	+= omapdrm/
> diff --git a/drivers/gpu/drm/atmel-hlcdc/Kconfig b/drivers/gpu/drm/atmel-hlcdc/Kconfig
> new file mode 100644
> index 0000000..6d0d785
> --- /dev/null
> +++ b/drivers/gpu/drm/atmel-hlcdc/Kconfig
> @@ -0,0 +1,13 @@
> +config DRM_ATMEL_HLCDC
> +	tristate "DRM Support for ATMEL HLCDC Display Controller"
> +	depends on DRM && OF && MFD_ATMEL_HLCDC && COMMON_CLK

I forgot to remove MFD_ATMEL_HLCDC dependency which is now selected...


> +	select DRM_GEM_CMA_HELPER
> +	select DRM_KMS_HELPER
> +	select DRM_KMS_FB_HELPER
> +	select DRM_KMS_CMA_HELPER
> +	select DRM_PANEL
> +	select MFD_ATMEL_HLCDC

here.

I'll fix that for the next version.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
