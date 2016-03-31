From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v5 45/46] drm: i915: switch to the atomic PWM API
Date: Thu, 31 Mar 2016 09:34:07 +0300
Message-ID: <87io03nokg.fsf@intel.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com> <1459368249-13241-46-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:57722 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751455AbcCaGeh (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Thu, 31 Mar 2016 02:34:37 -0400
In-Reply-To: <1459368249-13241-46-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: intel-gfx@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>, Shobhit Kumar <shobhit.kumar@intel.com>


[aggressively trimmed the recipient list, can't seem to be able to send
this otherwise]

On Wed, 30 Mar 2016, Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
> pwm_config/enable/disable() have been deprecated and should be replaced
> by pwm_apply_state().
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

Cc: Shobhit, any additional comments?

> ---
>  drivers/gpu/drm/i915/intel_panel.c | 39 +++++++++++++++++++++++++-------------
>  1 file changed, 26 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/intel_panel.c b/drivers/gpu/drm/i915/intel_panel.c
> index 21ee647..b86bd20 100644
> --- a/drivers/gpu/drm/i915/intel_panel.c
> +++ b/drivers/gpu/drm/i915/intel_panel.c
> @@ -538,10 +538,10 @@ static u32 bxt_get_backlight(struct intel_connector *connector)
>  static u32 pwm_get_backlight(struct intel_connector *connector)
>  {
>  	struct intel_panel *panel = &connector->panel;
> -	int duty_ns;
> +	struct pwm_state pstate;
>  
> -	duty_ns = pwm_get_duty_cycle(panel->backlight.pwm);
> -	return DIV_ROUND_UP(duty_ns * 100, CRC_PMIC_PWM_PERIOD_NS);
> +	pwm_get_state(panel->backlight.pwm, &pstate);
> +	return DIV_ROUND_UP(pstate.duty_cycle * 100, CRC_PMIC_PWM_PERIOD_NS);
>  }
>  
>  static u32 intel_panel_get_backlight(struct intel_connector *connector)
> @@ -630,9 +630,12 @@ static void bxt_set_backlight(struct intel_connector *connector, u32 level)
>  static void pwm_set_backlight(struct intel_connector *connector, u32 level)
>  {
>  	struct intel_panel *panel = &connector->panel;
> -	int duty_ns = DIV_ROUND_UP(level * CRC_PMIC_PWM_PERIOD_NS, 100);
> +	struct pwm_state pstate;
>  
> -	pwm_config(panel->backlight.pwm, duty_ns, CRC_PMIC_PWM_PERIOD_NS);
> +	pwm_get_state(panel->backlight.pwm, &pstate);
> +	pstate.duty_cycle = DIV_ROUND_UP(level * CRC_PMIC_PWM_PERIOD_NS, 100);
> +	pstate.period = CRC_PMIC_PWM_PERIOD_NS;
> +	pwm_apply_state(panel->backlight.pwm, &pstate);
>  }
>  
>  static void
> @@ -801,11 +804,15 @@ static void bxt_disable_backlight(struct intel_connector *connector)
>  static void pwm_disable_backlight(struct intel_connector *connector)
>  {
>  	struct intel_panel *panel = &connector->panel;
> +	struct pwm_state pstate;
>  
>  	/* Disable the backlight */
> -	pwm_config(panel->backlight.pwm, 0, CRC_PMIC_PWM_PERIOD_NS);
> +	pwm_get_state(panel->backlight.pwm, &pstate);
> +	pstate.duty_cycle = 0;
> +	pwm_apply_state(panel->backlight.pwm, &pstate);
>  	usleep_range(2000, 3000);
> -	pwm_disable(panel->backlight.pwm);
> +	pstate.enabled = false;
> +	pwm_apply_state(panel->backlight.pwm, &pstate);
>  }
>  
>  void intel_panel_disable_backlight(struct intel_connector *connector)
> @@ -1068,8 +1075,11 @@ static void bxt_enable_backlight(struct intel_connector *connector)
>  static void pwm_enable_backlight(struct intel_connector *connector)
>  {
>  	struct intel_panel *panel = &connector->panel;
> +	struct pwm_state pstate;
>  
> -	pwm_enable(panel->backlight.pwm);
> +	pwm_get_state(panel->backlight.pwm, &pstate);
> +	pstate.enabled = true;
> +	pwm_apply_state(panel->backlight.pwm, &pstate);
>  	intel_panel_actually_set_backlight(connector, panel->backlight.level);
>  }
>  
> @@ -1630,6 +1640,7 @@ static int pwm_setup_backlight(struct intel_connector *connector,
>  {
>  	struct drm_device *dev = connector->base.dev;
>  	struct intel_panel *panel = &connector->panel;
> +	struct pwm_state pstate;
>  	int retval;
>  
>  	/* Get the PWM chip for backlight control */
> @@ -1640,8 +1651,10 @@ static int pwm_setup_backlight(struct intel_connector *connector,
>  		return -ENODEV;
>  	}
>  
> -	retval = pwm_config(panel->backlight.pwm, CRC_PMIC_PWM_PERIOD_NS,
> -			    CRC_PMIC_PWM_PERIOD_NS);
> +	pwm_get_state(panel->backlight.pwm, &pstate);
> +	pstate.period = CRC_PMIC_PWM_PERIOD_NS;
> +	pstate.duty_cycle = CRC_PMIC_PWM_PERIOD_NS;
> +	retval = pwm_apply_state(panel->backlight.pwm, &pstate);
>  	if (retval < 0) {
>  		DRM_ERROR("Failed to configure the pwm chip\n");
>  		pwm_put(panel->backlight.pwm);
> @@ -1651,9 +1664,9 @@ static int pwm_setup_backlight(struct intel_connector *connector,
>  
>  	panel->backlight.min = 0; /* 0% */
>  	panel->backlight.max = 100; /* 100% */
> -	panel->backlight.level = DIV_ROUND_UP(
> -				 pwm_get_duty_cycle(panel->backlight.pwm) * 100,
> -				 CRC_PMIC_PWM_PERIOD_NS);
> +	pwm_get_state(panel->backlight.pwm, &pstate);
> +	panel->backlight.level = DIV_ROUND_UP(pstate.duty_cycle * 100,
> +					      pstate.period);
>  	panel->backlight.enabled = panel->backlight.level != 0;
>  
>  	return 0;

-- 
Jani Nikula, Intel Open Source Technology Center
