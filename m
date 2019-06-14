From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH] dt-bindings: pwm: Convert Allwinner PWM to a schema
Date: Fri, 14 Jun 2019 11:14:33 +0200
Message-ID: <20190614091433.xac42w3n7cx7buh6@flea>
References: <20190516120848.25007-1-maxime.ripard@bootlin.com>
 <20190607111838.xlx74cvcfhaob3wf@flea>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0724703540117316312=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190607111838.xlx74cvcfhaob3wf@flea>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


--===============0724703540117316312==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2ulork7hxmrmxe3s"
Content-Disposition: inline


--2ulork7hxmrmxe3s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 07, 2019 at 01:18:38PM +0200, Maxime Ripard wrote:
> On Thu, May 16, 2019 at 02:08:48PM +0200, Maxime Ripard wrote:
> > The Allwinner SoCs have a PWM controller supported in Linux, with a
> > matching Device Tree binding.
> >
> > Now that we have the DT validation in place, let's convert the device tree
> > bindings for that controller over to a YAML schemas.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> Ping?

Anyone? Should I just go ahead and merge it through the sunxi tree?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--2ulork7hxmrmxe3s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXQNleQAKCRDj7w1vZxhR
xbjNAP9u2gIWLx6Xy6i2Tdwxun/a8yx08d/HSPLSI34w6E8USAD9H4mszsZNc+Uo
kU9HDUDOJN7I1BDXvlp8F8tUft9QOAE=
=aqsN
-----END PGP SIGNATURE-----

--2ulork7hxmrmxe3s--


--===============0724703540117316312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0724703540117316312==--
