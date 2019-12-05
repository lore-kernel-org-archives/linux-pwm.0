Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35315 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfLEHMQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Dec 2019 02:12:16 -0500
Date: Thu, 5 Dec 2019 08:12:13 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Message-ID: <20191205071213.5ahi474skoz6y35p@pengutronix.de>
References: <20191021105739.1357629-1-thierry.reding@gmail.com>
 <20191021105739.1357629-2-thierry.reding@gmail.com>
 <041c05b7-f558-0249-0450-305dfa2697a9@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <041c05b7-f558-0249-0450-305dfa2697a9@collabora.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH 2/4] pwm: cros-ec: Cache duty cycle value
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org

Hello Enric,

On Mon, Oct 21, 2019 at 03:48:59PM +0200, Enric Balletbo i Serra wrote:
> On 21/10/19 12:57, Thierry Reding wrote:
> >  static const struct pwm_ops cros_ec_pwm_ops =3D {
> > +	.request =3D cros_ec_pwm_request,
> > +	.free =3D cros_ec_pwm_free,
>=20
> nit: Align using tabs for readability.

My personal opinion here is that not aligning is saner in the long run.
For me at least it doesn't disturb readability, and once you have

	.request	=3D cros_ec_pwm_request,
	.free		=3D cros_ec_pwm_free,
	.get_state	=3D cros_ec_pwm_get_state,
	.apply		=3D cros_ec_pwm_apply,
	.owner		=3D THIS_MODULE,

and want to set a new member with a long name, fixing the unrelated
lines adds churn and not fixing them looks as ugly as it does with mixed
styling. So I prefer to go with "<space>=3D<space>" from the start.

> >  	.get_state	=3D cros_ec_pwm_get_state,
> >  	.apply		=3D cros_ec_pwm_apply,
> >  	.owner		=3D THIS_MODULE,

But given that the already existing members are already using some
indention following this style seems right.

@Thierry: You didn't pick up this in your pull request. Should it stay
as it is now with the mixed style to not add churn, or should we fix to
something uniform?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
