From: Shobhit Kumar <kumar@shobhit.info>
Subject: Re: [Intel-gfx] [v2 7/7] drm/i915: Backlight control using CRC PMIC
 based PWM driver
Date: Thu, 25 Jun 2015 18:54:09 +0530
Message-ID: <CAAbrOmfyyNGMOi9XE-u_Wc9zc0jeOEond=YpMuf73kQcVLaSqg@mail.gmail.com>
References: <1434970465-12687-1-git-send-email-shobhit.kumar@intel.com>
	<1434970465-12687-8-git-send-email-shobhit.kumar@intel.com>
	<20150625084841.GZ5176@intel.com>
	<CAAbrOmeFcQGRa4_rv82vqgNx2rUXQOAxAfnTm7N=hjcfwNkbJA@mail.gmail.com>
	<20150625124732.GB5176@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20150625124732.GB5176@intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Shobhit Kumar <shobhit.kumar@intel.com>, Alexandre Courbot <gnurou@gmail.com>, Paul Bolle <pebolle@tiscali.nl>, Samuel Ortiz <sameo@linux.intel.com>, linux-pwm <linux-pwm@vger.kernel.org>, Jani Nikula <jani.nikula@intel.com>, Povilas Staniulis <wdmonster@gmail.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-gpio <linux-gpio@vger.kernel.org>, Brain WrecK <bloften80@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Chih-Wei Huang <cwhuang@android-x86.org>
List-Id: linux-pwm@vger.kernel.org

On Thu, Jun 25, 2015 at 6:17 PM, Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
> On Thu, Jun 25, 2015 at 05:38:50PM +0530, Shobhit Kumar wrote:
>> On Thu, Jun 25, 2015 at 2:18 PM, Ville Syrj=C3=A4l=C3=A4
>> <ville.syrjala@linux.intel.com> wrote:
>> > On Mon, Jun 22, 2015 at 04:24:25PM +0530, Shobhit Kumar wrote:
>> >> Use the CRC PWM device in intel_panel.c and add new MIPI backligh=
t
>> >> specififc callbacks
>> >>
>> >> v2: Modify to use pwm_config callback
>> >> v3: Addressed Jani's comments
>> >>     - Renamed all function as pwm_* instead of vlv_*
>> >>     - Call intel_panel_actually_set_backlight in enable function
>> >>     - Return -ENODEV in case pwm_get fails
>> >>     - in case pwm_config error return error cdoe from pwm_config
>> >>     - Cleanup pwm in intel_panel_destroy_backlight
>> >>
>> >> CC: Samuel Ortiz <sameo@linux.intel.com>
>> >> Cc: Linus Walleij <linus.walleij@linaro.org>
>> >> Cc: Alexandre Courbot <gnurou@gmail.com>
>> >> Cc: Thierry Reding <thierry.reding@gmail.com>
>> >> Signed-off-by: Shobhit Kumar <shobhit.kumar@intel.com>
>> >> ---
>> >>  drivers/gpu/drm/i915/intel_drv.h   |  4 ++
>> >>  drivers/gpu/drm/i915/intel_dsi.c   |  6 +++
>> >>  drivers/gpu/drm/i915/intel_panel.c | 95 ++++++++++++++++++++++++=
++++++++++++--
>> >>  3 files changed, 100 insertions(+), 5 deletions(-)
>> >>
>> >> diff --git a/drivers/gpu/drm/i915/intel_drv.h b/drivers/gpu/drm/i=
915/intel_drv.h
>> >> index 2afb31a..561c17f 100644
>> >> --- a/drivers/gpu/drm/i915/intel_drv.h
>> >> +++ b/drivers/gpu/drm/i915/intel_drv.h
>> >> @@ -182,6 +182,10 @@ struct intel_panel {
>> >>               bool enabled;
>> >>               bool combination_mode;  /* gen 2/4 only */
>> >>               bool active_low_pwm;
>> >> +
>> >> +             /* PWM chip */
>> >> +             struct pwm_device *pwm;
>> >> +
>> >>               struct backlight_device *device;
>> >>       } backlight;
>> >>
>> >> diff --git a/drivers/gpu/drm/i915/intel_dsi.c b/drivers/gpu/drm/i=
915/intel_dsi.c
>> >> index c4db74a..be8722c 100644
>> >> --- a/drivers/gpu/drm/i915/intel_dsi.c
>> >> +++ b/drivers/gpu/drm/i915/intel_dsi.c
>> >> @@ -402,6 +402,8 @@ static void intel_dsi_enable(struct intel_enc=
oder *encoder)
>> >>
>> >>               intel_dsi_port_enable(encoder);
>> >>       }
>> >> +
>> >> +     intel_panel_enable_backlight(intel_dsi->attached_connector)=
;
>> >>  }
>> >>
>> >>  static void intel_dsi_pre_enable(struct intel_encoder *encoder)
>> >> @@ -466,6 +468,8 @@ static void intel_dsi_pre_disable(struct inte=
l_encoder *encoder)
>> >>
>> >>       DRM_DEBUG_KMS("\n");
>> >>
>> >> +     intel_panel_disable_backlight(intel_dsi->attached_connector=
);
>> >> +
>> >>       if (is_vid_mode(intel_dsi)) {
>> >>               /* Send Shutdown command to the panel in LP mode */
>> >>               for_each_dsi_port(port, intel_dsi->ports)
>> >> @@ -1132,6 +1136,8 @@ void intel_dsi_init(struct drm_device *dev)
>> >>       }
>> >>
>> >>       intel_panel_init(&intel_connector->panel, fixed_mode, NULL)=
;
>> >> +     intel_panel_setup_backlight(connector,
>> >> +             (intel_encoder->crtc_mask =3D (1 << PIPE_A)) ? PIPE=
_A : PIPE_B);
>> >                                           ^
>> >
>> > Whoops. But since the PWM backlight doesn't need the initial pipe =
for
>> > anything you can actually just pass INVALID_PIPE here.
>> >
>>
>> You are right, its unused, but I thought passing right value still
>> made sense. Otherwise it makes it look like I am setting up back-lig=
ht
>> for invalid pipe, when the real meaning is something like
>> DONTCARE_PIPE
>
> Well it's not really about the pipe. It's about which set of BLC
> registers we're supoosed to use when using the BLC built into the
> display engine. And that's only done so that we take over the
> hardware state correctly. So INVALID_PIPE is just fine in this case
> since the backlight control has nothing to do with the pipe.
>

Ok, will update.

Regards
Shobhit
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
