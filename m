From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: lpc18xx-sct: don't reconfigure PWM in .request and
 .free
Date: Fri, 16 Nov 2018 11:01:14 +0100
Message-ID: <20181116100114.GB28631@ulmo>
References: <20181114115025.GC2620@ulmo>
 <20181116065208.3920-1-u.kleine-koenig@pengutronix.de>
 <1391bbe1-75b5-c86e-ed3a-1e1afb393917@mleia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0581092958952390162=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1391bbe1-75b5-c86e-ed3a-1e1afb393917@mleia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: linux-pwm@vger.kernel.org


--===============0581092958952390162==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 16, 2018 at 11:22:49AM +0200, Vladimir Zapolskiy wrote:
> Hello Uwe,
>=20
> On 11/16/2018 08:52 AM, Uwe Kleine-K=C3=B6nig wrote:
> > Regarding the .request case: The consumer might be interested in taking
> > over the configured state from the boot loader. So the initially
> > configured state should be retained.
> >=20
> > For the free case the PWM consumer is responsible to disable the PWM
> > before calling pwm_release and there are three subcases to consider:
> >=20
>=20
> the changes are fine per se, but please split them into two.
>=20
> Probably pwm_disable() misusage began spreading from commit 54b2a999a1675.

It's not really misusage to call pwm_disable(). It's basically just a
shortcut for ->disable() or the atomic equivalent for it. So I think the
commit that you point to is doing exactly the right thing. Also note
that that commit was made 6 years ago, and a lot of things have changed
since then.

Thierry

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvulWoACgkQ3SOs138+
s6EyKg/8CXMZQDRVpz3FQGUyaygy8kVaD1o6XxVgYal9zJR6aCB2EQS7I4BCryoa
U6SWx8UaguNbzoSgZjF8We2VyuMIhvQkNdrJplbDQ0mD9dpaqCzuGt6W5gyff8sZ
gpCTRFQYINk/thHNdW4eEEZESQELkxlmuZ1eKZK5/QH6guvCGd8diZSIvqTRRz8d
hVD39zJuponkP796X7BiPTb1LeU1NMpPNWW1Yu1khgs6osLbPSgt/CO2E3zG4FTS
ufmettSUEZGLm/edvWHEDQfMXBeWgaJoL9qyBbFCWk1Gc4vDhnkLUT0miVbeymr8
BF0CgQZA2qVB6X0a9IJv9Tc0IKWu0H6apgCcRYqd25OBguDvyol9E1lWpF0dHbqd
8veMqQDjGb4WOIxieZrKnkSZefpvI0E/monprH54QPbODfIKN31NydhwyNEYjoS1
Fhv/aR+PGptLJDZeLw1bJN6HPPCvJQifSvjwnH7fYPIy59JQtvtnD6WZKBFqG3KW
fIRKS5/bQ4w1Iy1qn12Oxf07wzOjwyJgag3uco7LgupXN+59d5nQYJpYC9jFEPhs
7kFeKvSZ7CnNhAkhcnar1EPIVDB/zeFZ+c1N1XAYJrGelC07XDtjmveK65wHlssU
izp9WCYEzh7egF2VxTGwB84i5gFnrXDPr9YZWF99kLcReYzUlII=
=axAw
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--


--===============0581092958952390162==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0581092958952390162==--
