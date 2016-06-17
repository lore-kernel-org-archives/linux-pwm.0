From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 2/4] mfd: cros_ec: add EC_PWM function definitions
Date: Fri, 17 Jun 2016 09:06:35 +0100
Message-ID: <20160617080635.GG21702@dell>
References: <1464916904-37554-1-git-send-email-briannorris@chromium.org>
 <1464916904-37554-3-git-send-email-briannorris@chromium.org>
 <20160616153817.GD21702@dell>
 <CAD=FV=X8eOQLbdAseL2_JwpOFNjSLDAi9hX=NrE=CfrrTZfAmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAD=FV=X8eOQLbdAseL2_JwpOFNjSLDAi9hX=NrE=CfrrTZfAmA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>, Thierry Reding <thierry.reding@gmail.com>, Olof Johansson <olof@lixom.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, linux-pwm <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Stephen Barber <smbarber@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Randall Spangler <rspangler@chromium.org>, Shawn Nematbakhsh <shawnn@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
List-Id: linux-pwm@vger.kernel.org

On Thu, 16 Jun 2016, Doug Anderson wrote:
> On Thu, Jun 16, 2016 at 8:38 AM, Lee Jones <lee.jones@linaro.org> wro=
te:
> > On Thu, 02 Jun 2016, Brian Norris wrote:
> >
> >> The EC_CMD_PWM_{GET,SET}_DUTY commands allow us to control a PWM t=
hat is
> >> attached to the EC, rather than the main host SoC. The API provide=
s
> >> functionality-based (e.g., keyboard light, backlight) or index-bas=
ed
> >> addressing of the PWM(s). Duty cycles are represented by a 16-bit =
value,
> >> where 0 maps to 0% duty cycle and U16_MAX maps to 100%. The period
> >> cannot be controlled.
> >>
> >> This command set is more generic than, e.g.,
> >> EC_CMD_PWM_{GET,SET}_KEYBOARD_BACKLIGHT and could possibly used to
> >> replace it on future products.
> >>
> >> Let's update the command header to include the definitions.
> >>
> >> Signed-off-by: Brian Norris <briannorris@chromium.org>
> >> ---
> >> v2: no change
> >>
> >>  include/linux/mfd/cros_ec_commands.h | 31 +++++++++++++++++++++++=
++++++++
> >>  1 file changed, 31 insertions(+)
> >>
> >> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/=
mfd/cros_ec_commands.h
> >> index 13b630c10d4c..d673575e0ada 100644
> >> --- a/include/linux/mfd/cros_ec_commands.h
> >> +++ b/include/linux/mfd/cros_ec_commands.h
> >> @@ -949,6 +949,37 @@ struct ec_params_pwm_set_fan_duty {
> >>       uint32_t percent;
> >>  } __packed;
> >>
> >> +#define EC_CMD_PWM_SET_DUTY 0x25
> >> +/* 16 bit duty cycle, 65535 =3D 100% */
> >> +#define EC_PWM_MAX_DUTY 65535
> >
> > Any reason this isn't represented in hex, like we do normally?
> >
> >> +enum ec_pwm_type {
> >> +     /* All types, indexed by board-specific enum pwm_channel */
> >> +     EC_PWM_TYPE_GENERIC =3D 0,
> >> +     /* Keyboard backlight */
> >> +     EC_PWM_TYPE_KB_LIGHT,
> >> +     /* Display backlight */
> >> +     EC_PWM_TYPE_DISPLAY_LIGHT,
> >> +     EC_PWM_TYPE_COUNT,
> >> +};
> >
> > Are these comments really necessary?  I'd recommend that if your
> > defines require comments, then they are not adequately named.  In t=
his
> > case however, I'd suggest that they are and the comments are
> > superfluous.
> >
> >> +struct ec_params_pwm_set_duty {
> >> +     uint16_t duty;     /* Duty cycle, EC_PWM_MAX_DUTY =3D 100% *=
/
> >> +     uint8_t pwm_type;  /* ec_pwm_type */
> >> +     uint8_t index;     /* Type-specific index, or 0 if unique */
> >> +} __packed;
> >
> > Please use kerneldoc format.
> >
> >> +#define EC_CMD_PWM_GET_DUTY 0x26
> >> +
> >> +struct ec_params_pwm_get_duty {
> >> +     uint8_t pwm_type;  /* ec_pwm_type */
> >> +     uint8_t index;     /* Type-specific index, or 0 if unique */
> >> +} __packed;
>=20
> Probably the reason for all of these non-kernel-isms is that this
> isn't a kernel file.  From the top of the file:
>=20
>  * NOTE: This file is copied verbatim from the ChromeOS EC Open Sourc=
e
>  * project in an attempt to make future updates easy to make.
>=20
> So the source of truth for this file is
> <https://chromium.googlesource.com/chromiumos/platform/ec/+/master/in=
clude/ec_commands.h>.
>=20
> Someone could probably submit a CL to that project to make it a littl=
e
> more kernel-ish and then we'd have to see if the EC team would accept
> such changes...

Hmmm... that kinda puts me in a difficult position.  Do I except
non-kernel code, which does not conform to our stands?

Naturally I'd be happier if you could try to make the code more
'kernely'.  The practices I mention above are still good ones, even if
you're not writing kernel specific code.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
