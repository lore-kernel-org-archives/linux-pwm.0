From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 0/2] switch to atomic PWM
Date: Thu, 6 Apr 2017 16:33:19 +0200
Message-ID: <20170406143319.GD8438@ulmo.ba.sec>
References: <1490189375-20384-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sgneBHv3152wZ8jf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1490189375-20384-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, boris.brezillon@free-electrons.com, alexandre.belloni@free-electrons.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.ferre@microchip.com, cristian.birsan@microchip.com, andrei.pistirica@microchip.com, tudor.ambarus@microchip.com, eugen.hristev@microchip.com
List-Id: linux-pwm@vger.kernel.org


--sgneBHv3152wZ8jf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2017 at 03:29:33PM +0200, Claudiu Beznea wrote:
> Changes in v3:
> - since v2 introduced per-IP register layout there is no need
> to keep update_cdty and set_cprd_cdty members in atmel_pwm_data
> data structure used in v2; doing in this way the atmel_pwm_data
> data structure will remain with only one member, regs. To avoid
> another level of indirection, the atmel_pwm_data has been removed
> and only atmel_pwm_registers data structure has been keept. In
> this way, "data" member of atmel_pwm_chip data structure was
> replaced by "regs" member; due to these changes prototype of
> atmel_pwm_get_driver_data() function was also changed;
> also, driver private data variables were renamed in the following
> format "atmel_pwm_regs_v*"
> - there is no need for the following checks at the begining
> of atmel_pwm_apply() which were present in v2:
>=20
> 	if (cstate.enabled &&
> 	    (cstate.polarity !=3D state->polarity ||
> 	     cstate.period !=3D state->period))
> 		pwm_reset =3D true;
>=20
> it is enough to add:
>=20
> 	if (state->enabled) {
> 		if (cstate.enabled &&
> 		    cstate.polarity =3D=3D state->polarity &&
> 		    cstate.period =3D=3D state->period) {
>=20
> inside "if (state->enabled)" block and also to check cstate.enabled
> instead of checking pwm_reset variable introduced in v2:
>=20
> 		if (cstate.enabled) {
> 			atmel_pwm_disable(chip, pwm, false);
> 		} else {
> 			ret =3D clk_enable(atmel_pwm->clk);
> 			if (ret) {
> 				dev_err(chip->dev, "failed to enable clock\n");
> 				return ret;
> 			}
> 		}
>=20
> Changes in v2:
> - update only duty factor without disabling the PWM channel
> - if PWM channel is enabled, period, as signal polarity, is
> updated by disabling + enabling the PWM channel
> - atmel_pwm_config_prepare() function has been removed and
> added instead two functions, one to compute the CPRD+Prescaler
> (atmel_pwm_calculate_cprd_and_pres()), one to compute CRDY
> (atmel_pwm_calculate_cdty())
> - atmel_pwm_config_set() body was directly moved to atmel_pwm_apply()
> - add 3 new members to atmel_pwm_data: update_cdty, set_cprd_cdty and
> regs:
> 	- update_cdty is called to configure duty factor without
> 	disabling PWM channel, when necessary
> 	- set_cprd_cdty is called to configure both period and
> 	duty factor parameters
> 	- regs keeps the period and duty registers and was added to
> 	have common functions for update_cdty and set_cprd_cdty
> 	members of atmel_pwm_data for all boards;
> - add a new parameter to atmel_pwm_disable(); this will be used in
> updating period + signal polarity by disabling + enabling the
> PWM channel. In this case, there is no need to disable PWM clock
> since new configuration will be imediately applied.
> - adapted the other reviewer comments excepts the one regarding
> "cdty =3D cprd - cycles;" from atmel_pwm_calculate_cdty() since
> in atmel_pwm_apply(), selecting polarity in the other way arround
> than is currently done in this commit will need the changing of DPOLI
> bit from Channel Mode Register, in order to keep the initial
> output level of PWM channel after disable operation; this works
> for sama5d2 but not for sam9rl which hasn't document the DPOLI
> bit in datasheet; sama5d3 also hasn't document the DPOLI bit in
> datasheet; one option was to have different aproach for different
> boards but the code becomes messy.
>=20
> Claudiu Beznea (2):
>   drivers: pwm: pwm-atmel: switch to atomic PWM
>   drivers: pwm: pwm-atmel: enable PWM on sama5d2
>=20
>  .../devicetree/bindings/pwm/atmel-pwm.txt          |   1 +
>  drivers/pwm/pwm-atmel.c                            | 276 ++++++++++-----=
------
>  2 files changed, 133 insertions(+), 144 deletions(-)

Applied, thanks.

Thierry

--sgneBHv3152wZ8jf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAljmUawACgkQ3SOs138+
s6GM3w//WPuF1+8E/PbotEhI000xIWuo670+axSqAgxpkhZtCuyP7Zv1srQYm+09
YRNOnfjqRTn0PZLJ4TrXtDlB1kQxlmIyBEFIOm1D3W9nEDU1X7cekF6CnOJ9R2Ce
pRt+TJdTqocUuxJNxqGqgt/sHYyjZAdtZY8xio7VSNrL66G5yEv+qwBPXZzd+SvA
QaZeS2JT/EP7kZEGLott/P4VzZfVkNnvIWr7y2uF5IsTwAEcKjWuNCsxz4/IcyrB
YE58JNBAE6kSNWTInwjITYzvpXxJ6/iIn0euYU44cQtOxPbZ+3PLMiROQlF8swBN
6a73ZEpjmlfxbycq7rw62r/rtk2k3xrXfkViMsiLUxJvNray4EMwV4Gw65Rum4I3
IrQ3ctZvaLDRbIaVBCcXoDIx3QefsNIRnT0m0k6HNk5FzKkxoQQ92Q4eU93qctlB
5Zv1sfk9vSGbzuFK+OxVZzVYjFd5apfn4jjzekXRNxPyYmi+QtHOgsSrbHaxFILJ
9i57nMr+bqYeOOpg9PaxBpPCz9mcQIlU6a5fCS2WBMYy3SRqEyAXzUKy8y8H8qd3
YXyyOGuMDNyaJ6O14awW0AMgUUk1FJacLXMq3JvXHsqZEnp9cLflAIJIyCHgNukT
wnz83bnPpZaqCbWXBlkQyrzDS1BR4v3efztv1Of1RWgUXLAJiMI=
=wJK0
-----END PGP SIGNATURE-----

--sgneBHv3152wZ8jf--
