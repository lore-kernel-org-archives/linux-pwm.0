From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/4] pwm: tegra: Add DT binding details to configure pin
 in suspends/resume
Date: Fri, 7 Apr 2017 12:19:47 +0200
Message-ID: <CACRpkdZXQNkQX1gYO3KEq8vc2+QD2h7JhjPHV-J+bu-tZULyYA@mail.gmail.com>
References: <1491401626-31303-1-git-send-email-ldewangan@nvidia.com>
 <1491401626-31303-4-git-send-email-ldewangan@nvidia.com> <33445b27-ae0b-b28e-afca-e7b776b4b7c0@nvidia.com>
 <20170406130315.GB7784@ulmo.ba.sec> <58E6405E.5020402@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <58E6405E.5020402-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Thu, Apr 6, 2017 at 3:19 PM, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> On Thursday 06 April 2017 06:33 PM, Thierry Reding wrote:
>> On Thu, Apr 06, 2017 at 09:57:09AM +0100, Jon Hunter wrote:
>>> On 05/04/17 15:13, Laxman Dewangan wrote:
>>>>
>>>> +state of the system. The configuration of pin is provided via the
>>>> pinctrl
>>>> +DT node as detailed in the pinctrl DT binding document
>>>> +       Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
>>>> +
>>>> +The PWM node will have following optional properties.
>>>> +pinctrl-names: Pin state names. Must be "suspend" and "resume".
>>>
>>> Why not just use the pre-defined names here? There is a pre-defined name
>>> for "default", "idle" and "sleep" and then you can use the following
>>> APIs and avoid the lookup of the state ...
>>>
>>> pinctrl_pm_select_default_state()
>>> pinctrl_pm_select_idle_state()
>>> pinctrl_pm_select_sleep_state()
>>>
>>> Note for i2c [0][1], I used "default" as the active/on state (which I
>>> know is not that descriptive) and then used 'idle' as the suspended
>>> state. This way we don't need any custom names.
>>
>> Agreed, I think that's how these states are meant to be used.
>
> I did quick grep for the pinctrl_pm_select_* functions in the code tree and
> found usage of these APIs in some of the places.
> I am taking the reference of i2c-st, i2c-nomadic and
> extcon/extcon-usb-gpio.c drivers and from this the interpretation is
>
> default state: When interface active and transfer need to be done in IO
> interface.
> idle state: Active state of the system but interface is not active, put in
> non-active state of the interface.
> sleep state: When system entering into suspend and IO interface is going to
> be inactive.
>
> So in PWM case, we will need the "default" and "sleep" state.
>
> In suspend(), set the "sleep" state and in resume, set the "default" state.
>
> + Linus W as I refereed his st/nomadik driver for reference.

It is actually documented:
include/linux/pinctrl/pinctrl-state.h

/*
 * Standard pin control state definitions
 */

/**
 * @PINCTRL_STATE_DEFAULT: the state the pinctrl handle shall be put
 *      into as default, usually this means the pins are up and ready to
 *      be used by the device driver. This state is commonly used by
 *      hogs to configure muxing and pins at boot, and also as a state
 *      to go into when returning from sleep and idle in
 *      .pm_runtime_resume() or ordinary .resume() for example.
 * @PINCTRL_STATE_INIT: normally the pinctrl will be set to "default"
 *      before the driver's probe() function is called.  There are some
 *      drivers where that is not appropriate becausing doing so would
 *      glitch the pins.  In those cases you can add an "init" pinctrl
 *      which is the state of the pins before drive probe.  After probe
 *      if the pins are still in "init" state they'll be moved to
 *      "default".
 * @PINCTRL_STATE_IDLE: the state the pinctrl handle shall be put into
 *      when the pins are idle. This is a state where the system is relaxed
 *      but not fully sleeping - some power may be on but clocks gated for
 *      example. Could typically be set from a pm_runtime_suspend() or
 *      pm_runtime_idle() operation.
 * @PINCTRL_STATE_SLEEP: the state the pinctrl handle shall be put into
 *      when the pins are sleeping. This is a state where the system is in
 *      its lowest sleep state. Could typically be set from an
 *      ordinary .suspend() function.
 */
#define PINCTRL_STATE_DEFAULT "default"
#define PINCTRL_STATE_INIT "init"
#define PINCTRL_STATE_IDLE "idle"
#define PINCTRL_STATE_SLEEP "sleep"

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
