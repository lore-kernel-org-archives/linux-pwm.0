From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v9 01/11] drm/i915: Use 64-bit division macro
Date: Wed, 18 Mar 2020 21:08:45 +0200
Message-ID: <87h7yleb0i.fsf@intel.com>
References: <cover.1584473399.git.gurus@codeaurora.org> <19661821c8eb32291e72ec091c267f915c365c52.1584473399.git.gurus@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:11075 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbgCRTIx (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 18 Mar 2020 15:08:53 -0400
In-Reply-To: <19661821c8eb32291e72ec091c267f915c365c52.1584473399.git.gurus@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, Uwe =?utf-8?Q?Kleine-K?= =?utf-8?Q?=C3=B6nig?= <uwe@kleine-koenig.org>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, linux-kernel@vger.kernel.org, Guru Das Srinagesh <gurus@codeaurora.org>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Chris Wilson <chris@chris-wilson.co.uk>, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Rodrigo Vivi <rodrigo.vivi@intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

On Tue, 17 Mar 2020, Guru Das Srinagesh <gurus@codeaurora.org> wrote:
> Since the PWM framework is switching struct pwm_state.duty_cycle's
> datatype to u64, prepare for this transition by using DIV_ROUND_UP_ULL
> to handle a 64-bit dividend.
>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: "Ville Syrjälä" <ville.syrjala@linux.intel.com>
> Cc: intel-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

Also ack for merging this via whichever tree you prefer; please let me
know if you want me to take this via drm-intel.

> ---
>  drivers/gpu/drm/i915/display/intel_panel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_panel.c b/drivers/gpu/drm/i915/display/intel_panel.c
> index bc14e9c..843cac1 100644
> --- a/drivers/gpu/drm/i915/display/intel_panel.c
> +++ b/drivers/gpu/drm/i915/display/intel_panel.c
> @@ -1868,7 +1868,7 @@ static int pwm_setup_backlight(struct intel_connector *connector,
>  
>  	panel->backlight.min = 0; /* 0% */
>  	panel->backlight.max = 100; /* 100% */
> -	panel->backlight.level = DIV_ROUND_UP(
> +	panel->backlight.level = DIV_ROUND_UP_ULL(
>  				 pwm_get_duty_cycle(panel->backlight.pwm) * 100,
>  				 CRC_PMIC_PWM_PERIOD_NS);
>  	panel->backlight.enabled = panel->backlight.level != 0;

-- 
Jani Nikula, Intel Open Source Graphics Center
