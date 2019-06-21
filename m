From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH] dt-bindings: pwm: Convert Allwinner PWM to a schema
Date: Fri, 21 Jun 2019 09:59:34 +0200
Message-ID: <20190621075934.dytb5ruv4gefgrmc@flea>
References: <20190516120848.25007-1-maxime.ripard@bootlin.com>
 <20190607111838.xlx74cvcfhaob3wf@flea>
 <20190614091433.xac42w3n7cx7buh6@flea>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2946458488973106281=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190614091433.xac42w3n7cx7buh6@flea>
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


--===============2946458488973106281==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="62wdhr4nif6wvnvt"
Content-Disposition: inline


--62wdhr4nif6wvnvt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 14, 2019 at 11:14:33AM +0200, Maxime Ripard wrote:
> On Fri, Jun 07, 2019 at 01:18:38PM +0200, Maxime Ripard wrote:
> > On Thu, May 16, 2019 at 02:08:48PM +0200, Maxime Ripard wrote:
> > > The Allwinner SoCs have a PWM controller supported in Linux, with a
> > > matching Device Tree binding.
> > >
> > > Now that we have the DT validation in place, let's convert the device tree
> > > bindings for that controller over to a YAML schemas.
> > >
> > > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> >
> > Ping?
>
> Anyone? Should I just go ahead and merge it through the sunxi tree?

Applied.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--62wdhr4nif6wvnvt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXQyOZQAKCRDj7w1vZxhR
xaoyAQDllw8NhQOREnODoAZvZn4YVeHtSyaUFs5GhVlJ9E8P2gEApIXSQcNFUihO
w01NbKzMlqQawHGtoNJdlW/lOxaBgA0=
=8Zfy
-----END PGP SIGNATURE-----

--62wdhr4nif6wvnvt--


--===============2946458488973106281==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2946458488973106281==--
