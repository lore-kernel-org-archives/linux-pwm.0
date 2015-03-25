From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 0/2] leds/pwm: don't call pwm_disable when setting
 brightness
Date: Wed, 25 Mar 2015 13:00:40 +0100
Message-ID: <20150325120039.GA16310@ulmo.nvidia.com>
References: <1423734290-19750-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150325101428.GB32677@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150325101428.GB32677@pengutronix.de>
Sender: linux-leds-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, linux-leds@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pwm@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2015 at 11:14:28AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> [Cc: +=3D akpm]
>=20
> On Thu, Feb 12, 2015 at 10:44:48AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > on arm/i.MX28 the leds connected to a pwm are still broken and it's more
> > than three years ago that I came up with these patches. I still consider
> > them to do the right thing and they fix a real bug.
> I'm really frustrated here. I want to fix a real bug, made several
> suggestions (with patches) how to fix it and still have to include my
> local patches in each project that uses leds on i.MX28's pwm output.
>=20
> Thierry, how can we get this resolved?

We have a couple of other drivers already solving similar issues. Look
for example at the pwm-bcm-kona driver. It explicitly sets the duty
cycle to 0 on ->disable() and then waits for some time before actually
disabling the clock (specifically to avoid a similar than you seem to
have on i.MX). See also the notes near the top of the driver source
file.

Another example is pwm-samsung. It also has code specifically aimed at
making sure the signal doesn't unexpectedly stay high after calling
pwm_disable(). See also the commit message of:

	6da89312a39b pwm: samsung: Fix output race on disabling

Both of these examples sound very similar to what you're describing, so
I think it'd be best to follow these examples and fix the i.MX driver to
behave as expected.

Irrespective of the behaviour of current drivers, the assumptions are
already codified in the user drivers and they all assume that calling
pwm_disable() means the PWM is off.

Thierry

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVEqNkAAoJEN0jrNd/PrOhjPsP/0jGIFWZ2X9VIlpFW57ek8Tg
+AjizHxiTg8AaKyRACl4UMPnu8rmMKRsdZCuThEZsQKKtIEOD5D05WLckdlh1Xxc
MpU3cpILtlyjUUPjvPUu230foXvLo7LsJIDKT0ropcgy67tvzqC438V/NDpElQ5F
kHMQGkQAfT728e30uupMdpEL5IdzbXWr9ePpaio3c20uzj2uqny+T3coadByYh7A
STVw4fBOHu/Dr/N78YPr2tc6zMNMovtl6M2zNbeox8xnqnVbnfl2xvC3h+b0qWNI
7TnJZQOHpP2lqjFydNE9WuFqPs84wriqDEklSNOUanPM2OEXLg6Mnw53Ackb6L6j
r5uoyMvRMhekSckkLdYSudWp0O9nNdrGHudJI3/XL1v5102/VGsZeqQnM/5XIK2N
4RHwSa7twZxrobhwzTcoXjYaRPnqAy+aMbxsxQn372yomF85koxOHCtECA4lfigG
4YoP6ikdzp1stWCUadspWUePV+6UoAA0gGCcV4Nt7QC3LeMxbzyUt/B4VaGPhH7Q
QVSl7w8nKV7L7oG4l6SlpxFiGMGdOMdX+OcyKOF6xTyWFY89nKVNs+YmNNjrCswL
3U1vd/8wBgLifaamdjsavgCefF89E2w4nQr6yD0Rr+BUr/93BRz6oh7SH31U3JCV
IeqIffsIEfGB3Qx493nC
=SfMn
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
