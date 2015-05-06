From: Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH 7/8] drm/i915: Use the CRC gpio for panel enable/disable
Date: Wed, 06 May 2015 16:11:11 +0300
Message-ID: <871titetqo.fsf@intel.com>
References: <1430316005-16480-1-git-send-email-shobhit.kumar@intel.com> <1430316005-16480-8-git-send-email-shobhit.kumar@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430316005-16480-8-git-send-email-shobhit.kumar@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: intel-gfx <intel-gfx@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, linux-pwm <linux-pwm@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, David Airlie <airlied@linux.ie>, Samuel Ortiz <sameo@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Povilas Staniulis <wdmonster@gmail.com>, Chih-Wei Huang <cwhuang@android-x86.org>, Shobhit Kumar <shobhit.kumar@intel.com>
List-Id: linux-pwm@vger.kernel.org

On Wed, 29 Apr 2015, Shobhit Kumar <shobhit.kumar@intel.com> wrote:
> The CRC (Crystal Cove) PMIC, controls the panel enable and disable
> signals for BYT for dsi panels. This is indicated in the VBT fields. Use
> that to initialize and use GPIO based control for these signals.
>
> v2: Use the newer gpiod interface(Alexandre)
> v3: Remove the redundant checks and unused code (Ville)
>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Shobhit Kumar <shobhit.kumar@intel.com>
> ---
>  drivers/gpu/drm/i915/intel_dsi.c | 32 ++++++++++++++++++++++++++++++--
>  drivers/gpu/drm/i915/intel_dsi.h |  6 ++++++
>  2 files changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/intel_dsi.c b/drivers/gpu/drm/i915/intel_dsi.c
> index 5196642..be55ffa 100644
> --- a/drivers/gpu/drm/i915/intel_dsi.c
> +++ b/drivers/gpu/drm/i915/intel_dsi.c
> @@ -31,6 +31,7 @@
>  #include <drm/drm_panel.h>
>  #include <drm/drm_mipi_dsi.h>
>  #include <linux/slab.h>
> +#include <linux/gpio/consumer.h>
>  #include "i915_drv.h"
>  #include "intel_drv.h"
>  #include "intel_dsi.h"
> @@ -415,6 +416,12 @@ static void intel_dsi_pre_enable(struct intel_encoder *encoder)
>  
>  	DRM_DEBUG_KMS("\n");
>  
> +	/* Panel Enable over CRC PMIC */
> +	if (intel_dsi->gpio_panel)
> +		gpiod_set_value_cansleep(intel_dsi->gpio_panel, 1);
> +
> +	msleep(intel_dsi->panel_on_delay);
> +
>  	/* Disable DPOunit clock gating, can stall pipe
>  	 * and we need DPLL REFA always enabled */
>  	tmp = I915_READ(DPLL(pipe));
> @@ -432,8 +439,6 @@ static void intel_dsi_pre_enable(struct intel_encoder *encoder)
>  	/* put device in ready state */
>  	intel_dsi_device_ready(encoder);
>  
> -	msleep(intel_dsi->panel_on_delay);
> -
>  	drm_panel_prepare(intel_dsi->panel);
>  
>  	for_each_dsi_port(port, intel_dsi->ports)
> @@ -576,6 +581,10 @@ static void intel_dsi_post_disable(struct intel_encoder *encoder)
>  
>  	msleep(intel_dsi->panel_off_delay);
>  	msleep(intel_dsi->panel_pwr_cycle_delay);
> +
> +	/* Panel Disable over CRC PMIC */
> +	if (intel_dsi->gpio_panel)
> +		gpiod_set_value_cansleep(intel_dsi->gpio_panel, 0);
>  }
>  
>  static bool intel_dsi_get_hw_state(struct intel_encoder *encoder,
> @@ -955,6 +964,11 @@ static void intel_dsi_encoder_destroy(struct drm_encoder *encoder)
>  		/* XXX: Logically this call belongs in the panel driver. */
>  		drm_panel_remove(intel_dsi->panel);
>  	}
> +
> +	/* dispose of the gpios */
> +	if (intel_dsi->gpio_panel)
> +		gpiod_put(intel_dsi->gpio_panel);
> +
>  	intel_encoder_destroy(encoder);
>  }
>  
> @@ -1071,6 +1085,20 @@ void intel_dsi_init(struct drm_device *dev)
>  		goto err;
>  	}
>  
> +	/*
> +	 * In case of BYT with CRC PMIC, we need to use GPIO for
> +	 * Panel control.
> +	 */
> +	if (dev_priv->vbt.dsi.config->pwm_blc == PPS_BLC_PMIC) {
> +		intel_dsi->gpio_panel =
> +			gpiod_get(dev->dev, "panel", GPIOD_OUT_HIGH);
> +
> +		if (IS_ERR(intel_dsi->gpio_panel)) {
> +			DRM_ERROR("Failed to own gpio for panel control\n");
> +			intel_dsi->gpio_panel = NULL;
> +		}
> +	}
> +
>  	intel_encoder->type = INTEL_OUTPUT_DSI;
>  	intel_encoder->cloneable = 0;
>  	drm_connector_init(dev, connector, &intel_dsi_connector_funcs,
> diff --git a/drivers/gpu/drm/i915/intel_dsi.h b/drivers/gpu/drm/i915/intel_dsi.h
> index 2784ac4..bf1bade 100644
> --- a/drivers/gpu/drm/i915/intel_dsi.h
> +++ b/drivers/gpu/drm/i915/intel_dsi.h
> @@ -29,6 +29,9 @@
>  #include <drm/drm_mipi_dsi.h>
>  #include "intel_drv.h"
>  
> +#define PPS_BLC_PMIC   0
> +#define PPS_BLC_SOC    1

Since these values are defined in the VBT, perhaps these should be in
intel_bios.h. Up to you, I'm fine either way.

Reviewed-by: Jani Nikula <jani.nikula@intel.com>


> +
>  /* Dual Link support */
>  #define DSI_DUAL_LINK_NONE		0
>  #define DSI_DUAL_LINK_FRONT_BACK	1
> @@ -42,6 +45,9 @@ struct intel_dsi {
>  	struct drm_panel *panel;
>  	struct intel_dsi_host *dsi_hosts[I915_MAX_PORTS];
>  
> +	/* GPIO Desc for CRC based Panel control */
> +	struct gpio_desc *gpio_panel;
> +
>  	struct intel_connector *attached_connector;
>  
>  	/* bit mask of ports being driven */
> -- 
> 2.1.0
>

-- 
Jani Nikula, Intel Open Source Technology Center
