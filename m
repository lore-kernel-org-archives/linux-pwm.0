From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 2/4] mfd: cros_ec: add EC_PWM function definitions
Date: Fri, 17 Jun 2016 17:55:52 +0200
Message-ID: <20160617155552.GB27475@ulmo.ba.sec>
References: <1464916904-37554-1-git-send-email-briannorris@chromium.org>
 <1464916904-37554-3-git-send-email-briannorris@chromium.org>
 <20160616153817.GD21702@dell>
 <CAD=FV=X8eOQLbdAseL2_JwpOFNjSLDAi9hX=NrE=CfrrTZfAmA@mail.gmail.com>
 <20160617080635.GG21702@dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33946 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbcFQP4D (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Jun 2016 11:56:03 -0400
Content-Disposition: inline
In-Reply-To: <20160617080635.GG21702@dell>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Olof Johansson <olof@lixom.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, linux-pwm <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Stephen Barber <smbarber@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Randall Spangler <rspangler@chromium.org>, Shawn Nematbakhsh <shawnn@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 17, 2016 at 09:06:35AM +0100, Lee Jones wrote:
> On Thu, 16 Jun 2016, Doug Anderson wrote:
> > On Thu, Jun 16, 2016 at 8:38 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > > On Thu, 02 Jun 2016, Brian Norris wrote:
> > >
> > >> The EC_CMD_PWM_{GET,SET}_DUTY commands allow us to control a PWM tha=
t is
> > >> attached to the EC, rather than the main host SoC. The API provides
> > >> functionality-based (e.g., keyboard light, backlight) or index-based
> > >> addressing of the PWM(s). Duty cycles are represented by a 16-bit va=
lue,
> > >> where 0 maps to 0% duty cycle and U16_MAX maps to 100%. The period
> > >> cannot be controlled.
> > >>
> > >> This command set is more generic than, e.g.,
> > >> EC_CMD_PWM_{GET,SET}_KEYBOARD_BACKLIGHT and could possibly used to
> > >> replace it on future products.
> > >>
> > >> Let's update the command header to include the definitions.
> > >>
> > >> Signed-off-by: Brian Norris <briannorris@chromium.org>
> > >> ---
> > >> v2: no change
> > >>
> > >>  include/linux/mfd/cros_ec_commands.h | 31 +++++++++++++++++++++++++=
++++++
> > >>  1 file changed, 31 insertions(+)
> > >>
> > >> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mf=
d/cros_ec_commands.h
> > >> index 13b630c10d4c..d673575e0ada 100644
> > >> --- a/include/linux/mfd/cros_ec_commands.h
> > >> +++ b/include/linux/mfd/cros_ec_commands.h
> > >> @@ -949,6 +949,37 @@ struct ec_params_pwm_set_fan_duty {
> > >>       uint32_t percent;
> > >>  } __packed;
> > >>
> > >> +#define EC_CMD_PWM_SET_DUTY 0x25
> > >> +/* 16 bit duty cycle, 65535 =3D 100% */
> > >> +#define EC_PWM_MAX_DUTY 65535
> > >
> > > Any reason this isn't represented in hex, like we do normally?
> > >
> > >> +enum ec_pwm_type {
> > >> +     /* All types, indexed by board-specific enum pwm_channel */
> > >> +     EC_PWM_TYPE_GENERIC =3D 0,
> > >> +     /* Keyboard backlight */
> > >> +     EC_PWM_TYPE_KB_LIGHT,
> > >> +     /* Display backlight */
> > >> +     EC_PWM_TYPE_DISPLAY_LIGHT,
> > >> +     EC_PWM_TYPE_COUNT,
> > >> +};
> > >
> > > Are these comments really necessary?  I'd recommend that if your
> > > defines require comments, then they are not adequately named.  In this
> > > case however, I'd suggest that they are and the comments are
> > > superfluous.
> > >
> > >> +struct ec_params_pwm_set_duty {
> > >> +     uint16_t duty;     /* Duty cycle, EC_PWM_MAX_DUTY =3D 100% */
> > >> +     uint8_t pwm_type;  /* ec_pwm_type */
> > >> +     uint8_t index;     /* Type-specific index, or 0 if unique */
> > >> +} __packed;
> > >
> > > Please use kerneldoc format.
> > >
> > >> +#define EC_CMD_PWM_GET_DUTY 0x26
> > >> +
> > >> +struct ec_params_pwm_get_duty {
> > >> +     uint8_t pwm_type;  /* ec_pwm_type */
> > >> +     uint8_t index;     /* Type-specific index, or 0 if unique */
> > >> +} __packed;
> >=20
> > Probably the reason for all of these non-kernel-isms is that this
> > isn't a kernel file.  From the top of the file:
> >=20
> >  * NOTE: This file is copied verbatim from the ChromeOS EC Open Source
> >  * project in an attempt to make future updates easy to make.
> >=20
> > So the source of truth for this file is
> > <https://chromium.googlesource.com/chromiumos/platform/ec/+/master/incl=
ude/ec_commands.h>.
> >=20
> > Someone could probably submit a CL to that project to make it a little
> > more kernel-ish and then we'd have to see if the EC team would accept
> > such changes...
>=20
> Hmmm... that kinda puts me in a difficult position.  Do I except
> non-kernel code, which does not conform to our stands?

I think usually code that doesn't adhere to kernel coding style ends up
in the staging tree until it's been cleaned up enough.

The rule doesn't quite apply here because cleaning up isn't the issue.
But I don't know if we have any best practices for this kind of thing.

One thing that I've seen done in the past is to have this kind of
cross-OS header generated from some sort of definition file (XML, ...)
with an output filter for all supported OSes. Is that something that
could perhaps be done here?

That said, this might not even be worth it in this case. While I see how
it makes sense to avoid work updating this file for various coding
styles, the content in this file defines an ABI, so really the only
changes will be additions, and once they're merged they become set in
stone anyway. The amount of work updating the header, even taking into
account different coding styles should be very low.

Thierry

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXZB2GAAoJEN0jrNd/PrOhqi4QAKd7TBMKoYEaYuwg58C6Ma8N
NfpEqqwsHJXrkwnjWy24TGGko9RXluMHlVSxKjxa+ijaJJa2hDxfJ9Q3D13dYisi
cK6ESyF5GDN6ikTUjt3Cm9mCmB9W/110oLTAgMkrLWpCbVFaOv0JNtVsvrQV+Xt8
doRV//c/oymrFiecD6k31X7ab+DP5+Y7H5AO+1t8EjHfrDc22xVF1xsOZDzYly32
K5XHQYgG1X8hcpUwKOdAzHln1X4nLoqEjXmNMdOVuvPQI8a384R+TeNGozCExPP+
tnZUwM1wHp66w5FO42VhhVfhuDRM4xsh0l0u9tSecdu1/pSbBuf9qKdm/VoadaUt
tyTI32WHBu/4MuINilxeq9hhJ6yzh70FCA1jIo+qbjL6i9qzb7hJ9zxL6SiOj1Ow
MRZYovKCnBs3wRsmBj1jFoSiVnotyHSuea7LbhFGM242GAZjFeCmnlM93sQdMFOU
spXepYfnXzs4xIAaVP2Zn7w+zZ6ja55EYbQRm2kaoIwOO9fiIF1xGjaz/JdTifTH
fSR5T2QboD8ZFultL3tn3IbnGL9qI+6AFYiCrpX2e/koc8JBfaoEIJKj1gSSS9o9
DiQdznfyepRKrg0MpP9NJ1dM/eruLOeEfhpvGx8z+gzhzhuOOa8yNHjofPmxY0qe
g5qz62GcNRH9DNf5BjtE
=IJXK
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
