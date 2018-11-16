From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: lpc18xx-sct: don't reconfigure PWM in .request and
 .free
Date: Fri, 16 Nov 2018 11:05:00 +0100
Message-ID: <20181116100500.GC28631@ulmo>
References: <20181114115025.GC2620@ulmo>
 <20181116065208.3920-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1324952256607350595=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181116065208.3920-1-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, Joachim Eastwood <manabian@gmail.com>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


--===============1324952256607350595==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Fig2xvG2VGoz8o/s"
Content-Disposition: inline


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 16, 2018 at 07:52:08AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Regarding the .request case: The consumer might be interested in taking
> over the configured state from the boot loader. So the initially
> configured state should be retained.
>=20
> For the free case the PWM consumer is responsible to disable the PWM
> before calling pwm_release and there are three subcases to consider:
>=20
>  a) The pwm is already off. Then there is no gain in disabling the PWM
>     once more.
>  b) The pwm is still running and there is a good reason for that. (Not
>     sure this is a valid case, I cannot imagine such a good reason.)
>     Then it is contra productive to disable the pwm.
>  c) The pwm is still running because the consumer failed to disable the
>     PWM. Then the consumer needs fixing and there is little incentive to
>     paper over the problem in the backend driver.
>=20
> This aligns the lpc18xx-sct driver to the other PWM drivers that also
> don't reconfigure the hardware in .request and .free.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-lpc18xx-sct.c | 3 ---
>  1 file changed, 3 deletions(-)

Applied, with some minor fixes to the commit message (pwm -> PWM,
pwm_release -> pwm_put(), ...).

Thanks,
Thierry

--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvulkwACgkQ3SOs138+
s6FFnBAAlXEbDJxhONeZTQzsXd5Sue7SUaZAuGQE5YTNpDQSXMIb52x5wpHoAS00
u2LOmhJdjwIaRZZdMbD9pj0yCl6BuLNja07O4NvUX52yWiwvKPx1oe8abo7IjY7l
8qv0wEIMXb+0FlsS3yP1OvqG2vrmMAfrAk4gPI49IgsMyWEvLtVpd+bX0JcnSOru
hpEKUbfoHRx5iTF8NH2xh8ily9DZcru1YwjkDt6w+gkjusoiA2TRQ05+8zTBkBc/
b172iIS2kH6YiL75GBv3P6TLkuSR4r3Lfr9fHfQTTYM/zbgbxiDybmbxfBBC4L0F
IkXR3jhO6pF6J6o4ixF9xiNOejLsuJ7uncJU3RzXUxEhMqZcR9Zzzp3MFNiFyGm5
j5pz+WihmaqtcQThgaHVJwRmxupea9VQoWcyq6Gsrn/nTTkudbEPDSmTiJKAKQ+A
9/qGakOXzF7lw8SGLUTKA9bikLM1Xwy9FnnShP5+1PusrdZAiWLMOCzJ5NmplGhu
yekoRT+DyQOGVpOjbZ4FShDXK5c4ePKa1BdduAz7yC3YG4clV+aWUTkJ3kmfyyq8
ZtVGBp9Gk1Z4C92TKmKrG3eNVsNjKL5rldSgMNpQ3mARED99tCZScIkWmBM4FlXD
SvaPbQr8LDd/sWFSkGD3oRrv86DgDt0SRxXIGo5znPpdRi+6MaY=
=BtLd
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--


--===============1324952256607350595==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1324952256607350595==--
