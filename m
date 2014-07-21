From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
Date: Mon, 21 Jul 2014 15:33:50 +0200
Message-ID: <20140721133348.GJ15238@ulmo>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140721143321.5bda6ea9@bbrezillon>
 <20140721125624.GF15238@ulmo>
 <2273675.A51UonkrgF@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fU0UwhtRbpo05rnG"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2273675.A51UonkrgF@avalon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Andrew Victor <linux-PelNFVqkFnVyf+4FbqDuWQ@public.gmane.org>, Jean-Jacques Hiblot <jjhiblot-dLKeG7h1OhBDOHtkgc7UlQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tim Niemeyer <tim.niemeyer@corscience>
List-Id: linux-pwm@vger.kernel.org


--fU0UwhtRbpo05rnG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2014 at 03:26:12PM +0200, Laurent Pinchart wrote:
> Hi Thierry,
>=20
> On Monday 21 July 2014 14:56:26 Thierry Reding wrote:
> > On Mon, Jul 21, 2014 at 02:33:21PM +0200, Boris BREZILLON wrote:
> > > On Mon, 21 Jul 2014 14:15:16 +0200 Thierry Reding wrote:
> > >> On Fri, Jul 18, 2014 at 04:51:52PM +0200, Boris BREZILLON wrote:
> > >>> On Tue, 15 Jul 2014 12:31:37 +0200 Thierry Reding wrote:
> > >>>> On Tue, Jul 15, 2014 at 12:06:19PM +0200, Boris BREZILLON wrote:
> > >>>>> On Mon, 14 Jul 2014 12:05:43 +0200 Thierry Reding wrote:
> > >>>>>> On Mon, Jul 07, 2014 at 06:42:59PM +0200, Boris BREZILLON wrote:
>=20
> [snip]
>=20
> > >>>>>>> + - atmel,panel: Should contain a phandle with 2 parameters.
> > >>>>>>> +   The first cell is a phandle to a DRM panel device
> > >>>>>>> +   The second cell encodes the RGB mode, which can take the
> > >>>>>>> following values: +   * 0: RGB444
> > >>>>>>> +   * 1: RGB565
> > >>>>>>> +   * 2: RGB666
> > >>>>>>> +   * 3: RGB888
> > >>>>>>=20
> > >>>>>> These are properties of the panel and should be obtained from
> > >>>>>> the panel directly rather than an additional cell in this
> > >>>>>> specifier.
> > >>>>>=20
> > >>>>> Okay.
> > >>>>> What's the preferred way of doing this ?
> > >>>>> What about defining an rgb-mode property in the panel node.
>=20
> [snip]
>=20
> > >>>> Also, like Laurent said, this shouldn't go into the device tree,
> > >>>> since it's already implied by the panel's compatible value, so we'd
> > >>>> be duplicating information.
> > >>>=20
> > >>> Again, this is not necessarily true (depending on your board design=
).
> > >>> One can decide to connect an RGB888 panel on an RGB666 bus and conn=
ect
> > >>> the missing pins to ground.
> > >>=20
> > >> I think in that case the board design itself could be considered as =
an
> > >> RGB888 to RGB666 bridge, and I think that's what the device tree sho=
uld
> > >> be describing rather than a panel with a variable number of input
> > >> formats.
> > >=20
> > > So, you're suggesting to add an RGB to RGB drm_bridge driver (and
> > > the appropriate DT bindings) to handle this case, right ?
> >=20
> > Yes, exactly.
>=20
> Wouldn't it be possible to implement RGB666 -> RGB888 support in a less=
=20
> complex way ? A standalone driver to describe signal routing seems like a=
n=20
> overly complex solution to me. I would prefer making the routing a proper=
ly of=20
> the link instead of a separate device.

I don't think the above is overly complex. After all the panel expects
RGB888, so it makes no sense to make it "configurable" to anything else.
Similarly if the encoder or bridge provides RGB666 then that's a fixed
function, too. So to represent this combination accurately you'll need
some form of translation entity inbetween, and it may just as well be a
bridge than something custom for that particular link.

Thierry

--fU0UwhtRbpo05rnG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTzRa8AAoJEN0jrNd/PrOhFPcP/j2axrsbzePX7PRPiomGKEfE
oydf/9yyK5y7PcxgW8oevfaSsViD9xuZNR/4tbenYTwAAzuLZtMKzG/W/oMgcYqb
4uFQu0EyE8ye6cUXdoP9ZyZn0l+Kt+gwGG6qe6tgsGkKaVEEsoN7njgdCPW2+Kgp
v7LlWYGh2xnGyl5t7NcpbH0Yy7yFC1IavxnOKp0m+OVf2PzdQy7EvT0UlTQwbCM6
R1topotYmGgcKY6TXMO/mWJJ+89Z5a5IciLS9IElQoGy1eplkkYOAyskQAEyUqk6
/kqGuO4bur65nl4ogUIFFTqsLejH87ugv34MR/HDfCsHrSxOl7oeO+qg7kawLHwl
NkFNUrrE3a0SUrKL9kpjsdnE0Jvp5D+x2R3es/IGdsNj2WCNZNxyatPXbUrRQvc0
jJxuLrSWia6mj/rxjJzJBHEmEMr4lxN0iLH9BDVzqWh9fyikF9+PugkpqzgJUMUW
eRAcDGlCrX81cOPtbukhX56zvSuoyma8Ajs8iWwUqIKlw7u8g+ydDMrd972Dgu4G
cYAnoMKEPH6kYkadVqBTpW0jTtt60wSyOrXqao7506T4Qqdl8x4Sntt7YGYuSkis
dbpLcitcCuk+iLskZk0z6jzkzEGH4nfbZ+aguaQvW5ks0VFqpJTIwla0IX+QYDSK
VcRLbaw2AuR2S8La1mG8
=mEoF
-----END PGP SIGNATURE-----

--fU0UwhtRbpo05rnG--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
