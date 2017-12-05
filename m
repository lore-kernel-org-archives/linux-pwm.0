From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3] pwm: imx: Let PWM be active during suspend
Date: Tue, 5 Dec 2017 09:47:01 +0100
Message-ID: <20171205084701.GC7386@ulmo>
References: <1511220443-26629-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XMCwj5IQnwKtuyBG"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36878 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751796AbdLEIrE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Dec 2017 03:47:04 -0500
Received: by mail-wr0-f195.google.com with SMTP id k61so20115859wrc.4
        for <linux-pwm@vger.kernel.org>; Tue, 05 Dec 2017 00:47:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1511220443-26629-1-git-send-email-festevam@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-pwm@vger.kernel.org, robh@kernel.org, linux@arm.linux.org.uk, Fabio Estevam <fabio.estevam@nxp.com>


--XMCwj5IQnwKtuyBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2017 at 09:27:23PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
>=20
> On a imx6q-cubox-i board, which has an LED driven by PWM, when the system
> goes into suspend the PWM block is disabled by default, then the PWM pin
> goes to logic level zero and turn on the LED during suspend, which is not
> really the behaviour we want to see.
>=20
> By keeping the PWM enabled during suspend via STOPEN bit, the pwm-leds
> driver sets the brightness to zero in suspend and then the LED is
> turned off as expected.
>=20
> So always set the STOPEN to fix the PWM behaviour in suspend.

It looks like this would also keep other PWMs enabled in suspend. If for
example you hooked up a fan to this PWM this change would make it so
that the fan would remain on during suspend. That doesn't sound
desirable to me.

On v2, I see this reply from you:

	Please note that on imx6qdl-cuboxi the pwm is active low.

I also see that imx6q-cubox-i uses the "fsl,imx27-pwm" compatible
version of this controller and that supports polarity inversion. I think
the correct thing to do here is to mark the PWM as inverted (according
to the DTS file it is actually the pwmleds node that has an active-low
property). If you invert the PWM you could add extra code to the PWM
driver to deal with this properly and set STOPEN only for inverted PWM
signals.

Thierry

--XMCwj5IQnwKtuyBG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlomXQMACgkQ3SOs138+
s6H1VQ//ZQOGs9FDhSsd2caNw/R0vkEapAmrZR1LccO1jKU3tdcDGjrkRxZsHyjA
lrHejjJUhX3/VQ66XP7sbaVlbMi8M9Tq7bhTYfcjTcmpmgxfSPNgq8SIE/AuOMqI
APVV4UFU8Kb4qlxZEX/h8Xh4luJuvE62RDLuPpaLJQy1KhDa5046+QZIjz4xMJC4
xdQi1iINgGF+UC8VSAjczUEKuWS2TotDDIc5zvjk3yIjGVUpj7IUVr6PoounHfWJ
9LnPHD62yLYtxjPiQBGgx/Gfd+PD7LgANPv7h/S57nh4RDYxA/TkwqbP+TCNbY9O
fnfBXdfpHpCV6GSW6Bm80Lv7CjMpZqH53AGzKG/tVaLkU74rXZ/PMtDCbiCHeUST
EkSyWQ0H9P2XQz/Nu3yEHE+f6AbJJRc6KtloJnUqnCBEFj6WkO/1HHaL3BXbqkgv
wApa2hx1O9G79nLQ0RxmwDratmFPaHmvcarAf+AswyvkJs9aa2OLaZ1+vFEwT6Bv
rIcWpcGKPfC9mVDQTGKA8ru12M2+6KFRFj0a1lfwJbYc/llpNubVma5MXgfxFy1O
UuAMgXeae8/EjDMlAozibSN1AGsXgKziBbx7M/5DKEYg4CF8R998ahQYzxcrggRM
drEyk78q4hcECE+MSswE9sgzgc9uZ1SE4fxuL2HBRiilDz7/45U=
=HJiY
-----END PGP SIGNATURE-----

--XMCwj5IQnwKtuyBG--
