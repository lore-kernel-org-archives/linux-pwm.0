From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] This adds a generic PWM framework driver
 for the PWM controller
Date: Sat, 23 Aug 2014 09:12:32 +0200
Message-ID: <20140823071232.GY15297@lukather>
References: <20140818180316.31807.3445.stgit@studio>
 <20140818192318.GJ15297@lukather>
 <CAKON4OwzFDDXqCF4VNkUXXJLp3smrB6Axp_x=D47sjbpoNbe+g@mail.gmail.com>
 <20140818201929.GL15297@lukather>
 <CAKON4OwDWqnu9Nn6rBFtUJX2f0eFVzBFhRMcvPAp=K6N1KpE0w@mail.gmail.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yAnL4aV/QzGiAmsL"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBGWU4KPQKGQELXF6GVQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKON4OwDWqnu9Nn6rBFtUJX2f0eFVzBFhRMcvPAp=K6N1KpE0w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: "jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, ARM Linux Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org


--yAnL4aV/QzGiAmsL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2014 at 08:11:40AM -0400, jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> On Mon, Aug 18, 2014 at 4:19 PM, Maxime Ripard
> <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> > On Mon, Aug 18, 2014 at 03:53:08PM -0400, jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> >> On Mon, Aug 18, 2014 at 3:23 PM, Maxime Ripard
> >> <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> >> > Hi,
> >> >
> >> > On Mon, Aug 18, 2014 at 02:03:16PM -0400, Jon Smirl wrote:
> >> >> found on Allwinner SoCs.x
> >> >>
> >> >> Signed-off-by: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> >
> >> > Is there any notable difference with Alexandre's driver?
> >> > https://lkml.org/lkml/2014/5/19/568
> >> >
> >> > If so, why didn't you posted incremental patches on top of his drive=
r?
> >>
> >> Better A10 support.
> >
> > Better how?
> >
> >> And I wrote this one without know about his.
> >
> > So you're just require us to trash an already extensively reviewed
> > driver and start from scratch again?
>=20
> Forget mine then.
>=20
> Problems in the other one....
> 1) The math is not right in either patch. Selsinork has been checking
> mine with a scope and just found another math error in mine. The
> internal math needs to be done in picoseconds or round off errors mess
> up the high frequency outputs (24Mhz, 12Mhz, 8Mhz, ...).

Feel free to report this to Alexandre so he fixes it then.

> 3) By-pass mode on the A20 is not implemented.
> 2) A10 is not correctly handled. Specifically the prescaler is
> different on the A10 vs A20.

And these can be sent as patches on top of Alexandre's driver, and
they would be very much welcome.

Remember to run scripts/checkpatch.pl before sending them though, and
by a quick look at your driver, you should also read
Documentation/CodingStyle.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--yAnL4aV/QzGiAmsL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT+D7gAAoJEBx+YmzsjxAgVJAP/3LMEVY1sDcju9u1Y1YkAO0M
dN1EHqLkOvF90svu7DBBeW9dbc8TLbwj1XLs5AVduCQ3BL3+SrLpTcFKBKAGTkd9
30kc3UetSIyoxHR5I2nbqPeOVacAVI8PUmE6YHGJmnaRbUwMauERnXfa/b09vlEI
UNHCl3HyhR1R8AEkqKeDT19Wc6tfNFnVGJ2rIAFGmrfJLVi9yAK0AwOuXuntgrKk
KLFIQWexMh56KrUkZKer+/uxKye+QpzwG5Wo3LCUMGrNKI03FG8QE+kDRaEfPmJR
DN2YpvBmCBIXK3gDniVFBgX88anRpmb8AQah4o54tUDVd18L13DpNClvKpRjDFYF
CJwglAkNSjvxyVchL9GzK/3XKi8W7kikT+cyJKJxY1MMG6a2fg0oJN8Jzq03stWK
6MEvp7W4mI+bxQeO00Oc1vRXccv9kSp723Z/1Mix/uJEGzbKvTkTiQAuHBBFnlhH
sBhVi7IZT1JBmLTQ/7F5hzC0jQYiQeb7QBHW3HL4aKrTHzWFI8n66Mklo2NCy6CW
QfDP8fVtOR1bCze1v5BOqVt4JAJQzoDrl+zfPDqJ8cQ//vd2JIVtyqZLCRiBYQcR
/niBF0pL9VS5WDTNn2hMtIupVrUjNQ6l5kTe70ROAOuBWoe5KcVi+47/Mof4PGr0
kytv3hD2d/RgnTAm2zoL
=JPc3
-----END PGP SIGNATURE-----

--yAnL4aV/QzGiAmsL--
