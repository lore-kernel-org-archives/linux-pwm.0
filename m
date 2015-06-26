From: Jani Nikula <jani.nikula@intel.com>
Subject: Re: [Intel-gfx] [v2 7/7] drm/i915: Backlight control using CRC PMIC based PWM driver
Date: Fri, 26 Jun 2015 11:31:17 +0300
Message-ID: <874mlu7twq.fsf@intel.com>
References: <1434970465-12687-1-git-send-email-shobhit.kumar@intel.com> <1434970465-12687-8-git-send-email-shobhit.kumar@intel.com> <20150625084841.GZ5176@intel.com> <CAAbrOmeFcQGRa4_rv82vqgNx2rUXQOAxAfnTm7N=hjcfwNkbJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CAAbrOmeFcQGRa4_rv82vqgNx2rUXQOAxAfnTm7N=hjcfwNkbJA@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Shobhit Kumar <kumar@shobhit.info>, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Shobhit Kumar <shobhit.kumar@intel.com>, Alexandre Courbot <gnurou@gmail.com>, Paul Bolle <pebolle@tiscali.nl>, Samuel Ortiz <sameo@linux.intel.com>, linux-pwm <linux-pwm@vger.kernel.org>, Povilas Staniulis <wdmonster@gmail.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-gpio <linux-gpio@vger.kernel.org>, Brain WrecK <bloften80@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Chih-Wei Huang <cwhuang@android-x86.org>
List-Id: linux-pwm@vger.kernel.org

On Thu, 25 Jun 2015, Shobhit Kumar <kumar@shobhit.info> wrote:
> On Thu, Jun 25, 2015 at 2:18 PM, Ville Syrj=C3=A4l=C3=A4
> <ville.syrjala@linux.intel.com> wrote:
>> On Mon, Jun 22, 2015 at 04:24:25PM +0530, Shobhit Kumar wrote:
>>> Use the CRC PWM device in intel_panel.c and add new MIPI backlight
>>> specififc callbacks
>>>
>>> v2: Modify to use pwm_config callback
>>> v3: Addressed Jani's comments
>>>     - Renamed all function as pwm_* instead of vlv_*
>>>     - Call intel_panel_actually_set_backlight in enable function
>>>     - Return -ENODEV in case pwm_get fails
>>>     - in case pwm_config error return error cdoe from pwm_config
>>>     - Cleanup pwm in intel_panel_destroy_backlight
>>>
>>> CC: Samuel Ortiz <sameo@linux.intel.com>
>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>> Cc: Alexandre Courbot <gnurou@gmail.com>
>>> Cc: Thierry Reding <thierry.reding@gmail.com>
>>> Signed-off-by: Shobhit Kumar <shobhit.kumar@intel.com>
>>> ---
>>>  drivers/gpu/drm/i915/intel_drv.h   |  4 ++
>>>  drivers/gpu/drm/i915/intel_dsi.c   |  6 +++
>>>  drivers/gpu/drm/i915/intel_panel.c | 95 ++++++++++++++++++++++++++=
++++++++++--
>>>  3 files changed, 100 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/i915/intel_drv.h b/drivers/gpu/drm/i91=
5/intel_drv.h
>>> index 2afb31a..561c17f 100644
>>> --- a/drivers/gpu/drm/i915/intel_drv.h
>>> +++ b/drivers/gpu/drm/i915/intel_drv.h
>>> @@ -182,6 +182,10 @@ struct intel_panel {
>>>               bool enabled;
>>>               bool combination_mode;  /* gen 2/4 only */
>>>               bool active_low_pwm;
>>> +
>>> +             /* PWM chip */
>>> +             struct pwm_device *pwm;
>>> +
>>>               struct backlight_device *device;
>>>       } backlight;
>>>
>>> diff --git a/drivers/gpu/drm/i915/intel_dsi.c b/drivers/gpu/drm/i91=
5/intel_dsi.c
>>> index c4db74a..be8722c 100644
>>> --- a/drivers/gpu/drm/i915/intel_dsi.c
>>> +++ b/drivers/gpu/drm/i915/intel_dsi.c
>>> @@ -402,6 +402,8 @@ static void intel_dsi_enable(struct intel_encod=
er *encoder)
>>>
>>>               intel_dsi_port_enable(encoder);
>>>       }
>>> +
>>> +     intel_panel_enable_backlight(intel_dsi->attached_connector);
>>>  }
>>>
>>>  static void intel_dsi_pre_enable(struct intel_encoder *encoder)
>>> @@ -466,6 +468,8 @@ static void intel_dsi_pre_disable(struct intel_=
encoder *encoder)
>>>
>>>       DRM_DEBUG_KMS("\n");
>>>
>>> +     intel_panel_disable_backlight(intel_dsi->attached_connector);
>>> +
>>>       if (is_vid_mode(intel_dsi)) {
>>>               /* Send Shutdown command to the panel in LP mode */
>>>               for_each_dsi_port(port, intel_dsi->ports)
>>> @@ -1132,6 +1136,8 @@ void intel_dsi_init(struct drm_device *dev)
>>>       }
>>>
>>>       intel_panel_init(&intel_connector->panel, fixed_mode, NULL);
>>> +     intel_panel_setup_backlight(connector,
>>> +             (intel_encoder->crtc_mask =3D (1 << PIPE_A)) ? PIPE_A=
 : PIPE_B);
>>                                           ^
>>
>> Whoops. But since the PWM backlight doesn't need the initial pipe fo=
r
>> anything you can actually just pass INVALID_PIPE here.
>>
>
> You are right, its unused, but I thought passing right value still
> made sense. Otherwise it makes it look like I am setting up back-ligh=
t
> for invalid pipe, when the real meaning is something like
> DONTCARE_PIPE
>
>>>
>>>       return;
>>>
>>> diff --git a/drivers/gpu/drm/i915/intel_panel.c b/drivers/gpu/drm/i=
915/intel_panel.c
>>> index 7d83527..2aa30db 100644
>>> --- a/drivers/gpu/drm/i915/intel_panel.c
>>> +++ b/drivers/gpu/drm/i915/intel_panel.c
>>> @@ -32,8 +32,12 @@
>>>
>>>  #include <linux/kernel.h>
>>>  #include <linux/moduleparam.h>
>>> +#include <linux/pwm.h>
>>>  #include "intel_drv.h"
>>>
>>> +#define CRC_PMIC_PWM_PERIOD_NS       21333
>>> +#define CRC_PMIC_PWM_STEPS   255
>>
>> This define appears to be unused.
>>
>
> Yeah, missed removing it.
>
>>> +
>>>  void
>>>  intel_fixed_panel_mode(const struct drm_display_mode *fixed_mode,
>>>                      struct drm_display_mode *adjusted_mode)
>>> @@ -544,6 +548,15 @@ static u32 bxt_get_backlight(struct intel_conn=
ector *connector)
>>>       return I915_READ(BXT_BLC_PWM_DUTY1);
>>>  }
>>>
>>> +static u32 pwm_get_backlight(struct intel_connector *connector)
>>> +{
>>> +     struct intel_panel *panel =3D &connector->panel;
>>> +     int duty_ns;
>>> +
>>> +     duty_ns =3D pwm_get_duty_cycle(panel->backlight.pwm);
>>> +     return DIV_ROUND_UP(duty_ns * 100, CRC_PMIC_PWM_PERIOD_NS);
>>> +}
>>> +
>>>  static u32 intel_panel_get_backlight(struct intel_connector *conne=
ctor)
>>>  {
>>>       struct drm_device *dev =3D connector->base.dev;
>>> @@ -632,6 +645,14 @@ static void bxt_set_backlight(struct intel_con=
nector *connector, u32 level)
>>>       I915_WRITE(BXT_BLC_PWM_DUTY1, level);
>>>  }
>>>
>>> +static void pwm_set_backlight(struct intel_connector *connector, u=
32 level)
>>> +{
>>> +     struct intel_panel *panel =3D &connector->panel;
>>> +     int duty_ns =3D DIV_ROUND_UP(level * CRC_PMIC_PWM_PERIOD_NS, =
100);
>>> +
>>> +     pwm_config(panel->backlight.pwm, duty_ns, CRC_PMIC_PWM_PERIOD=
_NS);
>>> +}
>>> +
>>>  static void
>>>  intel_panel_actually_set_backlight(struct intel_connector *connect=
or, u32 level)
>>>  {
>>> @@ -769,6 +790,16 @@ static void bxt_disable_backlight(struct intel=
_connector *connector)
>>>       I915_WRITE(BXT_BLC_PWM_CTL1, tmp & ~BXT_BLC_PWM_ENABLE);
>>>  }
>>>
>>> +static void pwm_disable_backlight(struct intel_connector *connecto=
r)
>>> +{
>>> +     struct intel_panel *panel =3D &connector->panel;
>>> +
>>> +     /* Disable the backlight */
>>> +     pwm_config(panel->backlight.pwm, 0, CRC_PMIC_PWM_PERIOD_NS);
>>> +     usleep_range(2000, 3000);
>>> +     pwm_disable(panel->backlight.pwm);
>>> +}
>>> +
>>>  void intel_panel_disable_backlight(struct intel_connector *connect=
or)
>>>  {
>>>       struct drm_device *dev =3D connector->base.dev;
>>> @@ -1002,6 +1033,14 @@ static void bxt_enable_backlight(struct inte=
l_connector *connector)
>>>       I915_WRITE(BXT_BLC_PWM_CTL1, pwm_ctl | BXT_BLC_PWM_ENABLE);
>>>  }
>>>
>>> +static void pwm_enable_backlight(struct intel_connector *connector=
)
>>> +{
>>> +     struct intel_panel *panel =3D &connector->panel;
>>> +
>>> +     pwm_enable(panel->backlight.pwm);
>>> +     intel_panel_actually_set_backlight(connector, panel->backligh=
t.level);
>>> +}
>>> +
>>>  void intel_panel_enable_backlight(struct intel_connector *connecto=
r)
>>>  {
>>>       struct drm_device *dev =3D connector->base.dev;
>>> @@ -1378,6 +1417,40 @@ bxt_setup_backlight(struct intel_connector *=
connector, enum pipe unused)
>>>       return 0;
>>>  }
>>>
>>> +static int pwm_setup_backlight(struct intel_connector *connector,
>>> +                            enum pipe pipe)
>>> +{
>>> +     struct drm_device *dev =3D connector->base.dev;
>>> +     struct intel_panel *panel =3D &connector->panel;
>>> +     int retval =3D -1;
>>
>> No need to initialize it.
>>
>>> +
>>> +     /* Get the PWM chip for backlight control */
>>> +     panel->backlight.pwm =3D pwm_get(dev->dev, "pwm_backlight");
>>> +     if (IS_ERR(panel->backlight.pwm)) {
>>> +             DRM_ERROR("Failed to own the pwm chip\n");
>>> +             panel->backlight.pwm =3D NULL;
>>> +             return -ENODEV;
>>> +     }
>>> +
>>> +     retval =3D pwm_config(panel->backlight.pwm, CRC_PMIC_PWM_PERI=
OD_NS,
>>> +                         CRC_PMIC_PWM_PERIOD_NS);
>>> +     if (retval < 0) {
>>> +             DRM_ERROR("Failed to configure the pwm chip\n");
>>> +             pwm_put(panel->backlight.pwm);
>>> +             panel->backlight.pwm =3D NULL;
>>> +             return retval;
>>> +     }
>>> +
>>> +     panel->backlight.min =3D 0; /* 0% */
>>> +     panel->backlight.max =3D 100; /* 100% */
>>> +     panel->backlight.level =3D DIV_ROUND_UP(
>>> +                              pwm_get_duty_cycle(panel->backlight.=
pwm) * 100,
>>> +                              CRC_PMIC_PWM_PERIOD_NS);
>>> +     panel->backlight.enabled =3D panel->backlight.level !=3D 0;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>>  int intel_panel_setup_backlight(struct drm_connector *connector, e=
num pipe pipe)
>>>  {
>>>       struct drm_device *dev =3D connector->dev;
>>> @@ -1421,6 +1494,10 @@ void intel_panel_destroy_backlight(struct dr=
m_connector *connector)
>>>       struct intel_connector *intel_connector =3D to_intel_connecto=
r(connector);
>>>       struct intel_panel *panel =3D &intel_connector->panel;
>>>
>>> +     /* dispose of the pwm */
>>> +     if (panel->backlight.pwm)
>>> +             pwm_put(panel->backlight.pwm);
>>> +
>>>       panel->backlight.present =3D false;
>>>  }
>>>
>>> @@ -1448,11 +1525,19 @@ void intel_panel_init_backlight_funcs(struc=
t drm_device *dev)
>>>               dev_priv->display.set_backlight =3D pch_set_backlight=
;
>>>               dev_priv->display.get_backlight =3D pch_get_backlight=
;
>>>       } else if (IS_VALLEYVIEW(dev)) {
>>> -             dev_priv->display.setup_backlight =3D vlv_setup_backl=
ight;
>>> -             dev_priv->display.enable_backlight =3D vlv_enable_bac=
klight;
>>> -             dev_priv->display.disable_backlight =3D vlv_disable_b=
acklight;
>>> -             dev_priv->display.set_backlight =3D vlv_set_backlight=
;
>>> -             dev_priv->display.get_backlight =3D vlv_get_backlight=
;
>>> +             if (dev_priv->vbt.has_mipi) {
>>
>> Do all VLV DSI desins use the PMIC for backlight, or is there
>> something more specific in VBT we could look at?
>>
>
> No, VLV designs can actually also use LPSS PWM as well as DISPLAY_PWM=
=2E
> Infact we had a case where even for eDP, customer design used LPSS. S=
o
> this flag in VBT for mipi_config block "pwm_blc" indicate the same fo=
r
> now. But today this is only PMIC Vs LPSS. There is another update
> pending where we have full flexibility in VBT to define PMIC or LPSS
> or DISPLAY_PWM to handle the eDP case that I mentioned above.

Side note, we may need to move the hooks from dev_priv->display to
connector->panel in the future.

BR,
Jani.


>
>> And what about CHT?
>
> Its the same as I described above. But then beyond CHT, there is
> effort to unify this all as only one SoC PWM.
>
>>
>> Othwerwise things seem reasonable, so with the the
>> intel_panel_setup_backlight() pipe thing fixed this patch is
>> Reviewed-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
>>
>> I also gave the entire series a go on my FFRD8 and it appears to wor=
k
>> just fine, so you can also add
>> Tested-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
>> to all the patches if you want.
>
> Thanks a lot for testing it out.
>
> Regards
> Shobhit
>
>>
>>> +                     dev_priv->display.setup_backlight =3D pwm_set=
up_backlight;
>>> +                     dev_priv->display.enable_backlight =3D pwm_en=
able_backlight;
>>> +                     dev_priv->display.disable_backlight =3D pwm_d=
isable_backlight;
>>> +                     dev_priv->display.set_backlight =3D pwm_set_b=
acklight;
>>> +                     dev_priv->display.get_backlight =3D pwm_get_b=
acklight;
>>> +             } else {
>>> +                     dev_priv->display.setup_backlight =3D vlv_set=
up_backlight;
>>> +                     dev_priv->display.enable_backlight =3D vlv_en=
able_backlight;
>>> +                     dev_priv->display.disable_backlight =3D vlv_d=
isable_backlight;
>>> +                     dev_priv->display.set_backlight =3D vlv_set_b=
acklight;
>>> +                     dev_priv->display.get_backlight =3D vlv_get_b=
acklight;
>>> +             }
>>>       } else if (IS_GEN4(dev)) {
>>>               dev_priv->display.setup_backlight =3D i965_setup_back=
light;
>>>               dev_priv->display.enable_backlight =3D i965_enable_ba=
cklight;
>>> --
>>> 1.9.1
>>>
>>> _______________________________________________
>>> Intel-gfx mailing list
>>> Intel-gfx@lists.freedesktop.org
>>> http://lists.freedesktop.org/mailman/listinfo/intel-gfx
>>
>> --
>> Ville Syrj=C3=A4l=C3=A4
>> Intel OTC
>> _______________________________________________
>> Intel-gfx mailing list
>> Intel-gfx@lists.freedesktop.org
>> http://lists.freedesktop.org/mailman/listinfo/intel-gfx

--=20
Jani Nikula, Intel Open Source Technology Center
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
