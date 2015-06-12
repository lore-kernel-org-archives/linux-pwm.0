From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/1] Atmel-PWM: Fixed the PWM channel enable/disable
 issue which will cause the PWM output stop working after reenable. THe PWM
 channel status register is read to ensure  the PWM channel is really enabled
 or disabled.
Date: Fri, 12 Jun 2015 13:45:56 +0200
Message-ID: <20150612114555.GL19400@ulmo.nvidia.com>
References: <1412197710-17731-1-git-send-email-ryang@hach.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dxRQSzdsN/lOP445"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:34835 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbbFLLqf (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Jun 2015 07:46:35 -0400
Content-Disposition: inline
In-Reply-To: <1412197710-17731-1-git-send-email-ryang@hach.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: robert yang <hachyang@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, ryang <ryang@hach.com>


--dxRQSzdsN/lOP445
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 01, 2014 at 03:08:30PM -0600, robert yang wrote:
> From: ryang <ryang@hach.com>
>=20
> Signed-off-by: ryang <ryang@hach.com>
> ---
>  drivers/pwm/pwm-atmel.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Seems like I never got around to review this. Sorry for that.

First, you need to change the commit subject and message. The first line
should be a short description of what the patch does, something like
this:

	pwm: atmel: Ensure channel is enabled or disabled

Followed by a more verbose description of the change. What I don't
understand here is under what circumstances it can happen that the
channel isn't getting enabled. Is this because some error happened and
therefore the register needs to be written again? Or is it just that we
need to wait for some time for the PWM to become enabled and we use the
PWM enable register for that?

> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> index 6e700a5..bab933a 100644
> --- a/drivers/pwm/pwm-atmel.c
> +++ b/drivers/pwm/pwm-atmel.c
> @@ -237,7 +237,10 @@ static int atmel_pwm_enable(struct pwm_chip *chip, s=
truct pwm_device *pwm)
>  	}
> =20
>  	atmel_pwm_writel(atmel_pwm, PWM_ENA, 1 << pwm->hwpwm);
> -
> +	while (!(atmel_pwm_readl(atmel_pwm, PWM_SR) & (1 << pwm->hwpwm))) {
> +		atmel_pwm_writel(atmel_pwm, PWM_ENA, 1 << pwm->hwpwm);
> +		cpu_relax();
> +	}

So this indicates that the PWM_ENA register is used to enable multiple
PWM channels. Given that there is a PWM_DIS register too, I suspect that
this is a write-only register, so writing zeroes to an enable bit
doesn't actually cause the corresponding PWM to be disabled. That would
have been a nice explanation for why the original code could break.

>  	return 0;
>  }
> =20
> @@ -246,7 +249,10 @@ static void atmel_pwm_disable(struct pwm_chip *chip,=
 struct pwm_device *pwm)
>  	struct atmel_pwm_chip *atmel_pwm =3D to_atmel_pwm_chip(chip);
> =20
>  	atmel_pwm_writel(atmel_pwm, PWM_DIS, 1 << pwm->hwpwm);
> -
> +	while (atmel_pwm_readl(atmel_pwm, PWM_SR) & (1 << pwm->hwpwm)) {
> +		atmel_pwm_writel(atmel_pwm, PWM_DIS, 1 << pwm->hwpwm);
> +		cpu_relax();
> +	}
>  	clk_disable(atmel_pwm->clk);
>  }
> =20

Same here. I don't really understand why this change is necessary. Maybe
you can provide a more detailed description of the error you're seeing.
Also adding Nicolas to Cc, perhaps he can help find out what the issue
is with the current code.

Thierry

--dxRQSzdsN/lOP445
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVesZxAAoJEN0jrNd/PrOhrcUP/jrMOn51en5HGP0DrW84rn6k
ySEf5oTPhXRasGrTasEQPt45nM/ynQ1IEdc2S+1SRTwGMBFnWrWnzzIwvVeyrdYs
PQWtPv71L8Bbz9/6mB4kYwlmF2acweK0T5auopGtGA40T978yATNi+a9UTwkVycP
G50FluhMG9GvV6JqkDRyxyLkGTpcNNVlnQiLWgPiVvQQunxZWshmILnY/5+FudSr
DuJK4VPiMKYvpTn0Jl4QiavyRCoT+Lhhtp3J65eckkvosQLdRo4KejrfYT8GtRjV
WXxdn0FS50iRAxIOQxhNMb1NAcngkddNGmOM4DGs2nSlNDdtYxbJxOS2rJrzNVnZ
aIDnqWXzH37T6Ry0jC6lW30ACcECrOaGzJujhTQ6jGvrBPa6qIZX0HEJEb4goQNN
8t7xue3FKQ2wI5fshS7iWbbE9MZJxkqlbW7ITE17cmcEVtv92c9+4yRolEZRXA1z
zeUC2Vzs1arzuDw14GD2UU/s3E4M8IsMJPPj8SbfaVP+dFzIYNu/p2iDLIRR7cf+
VHSGsWRyYfl/HJNYBL44NXP+JwHYj89BMUZHcS8vmLy9ews4dVoYxbmKevOOX/Yt
lO/mLgyyLxwT+U/unUiao9I1f3MtvgnQiyqhh6uGP44mzp7rTi3/L7YSwTwKepzA
5fKZ7xRZC+UEC2PK+MwQ
=+OzN
-----END PGP SIGNATURE-----

--dxRQSzdsN/lOP445--
