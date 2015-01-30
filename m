From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v8 0/2] Imagination Technologies PWM support
Date: Fri, 30 Jan 2015 12:26:05 +0100
Message-ID: <20150130112604.GB32359@ulmo>
References: <1420826088-13113-1-git-send-email-ezequiel.garcia@imgtec.com>
 <54BE3369.9000802@imgtec.com>
 <54CA6089.50505@imgtec.com>
 <20150130091832.GA16744@ulmo>
 <54CB646C.7040705@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54CB646C.7040705-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2015 at 08:01:00AM -0300, Ezequiel Garcia wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>=20
> Hi Thierry,
>=20
> On 01/30/2015 06:18 AM, Thierry Reding wrote:
> > On Thu, Jan 29, 2015 at 01:32:09PM -0300, Ezequiel Garcia wrote:
> >> On 01/20/2015 07:52 AM, Ezequiel Garcia wrote:
> >>>=20
> >>>=20
> >>> On 01/09/2015 02:54 PM, Ezequiel Garcia wrote:
> >>>> A new round for the IMG PWM driver.
> >>>>=20
> >>>> The IMG PWM controller is muxed with a PDM controller,
> >>>> through a shared so-called periph register bit, which sets
> >>>> the output as PWM or PDM. Because this register is not part
> >>>> of the pin controller block, but rather PWM/PDM specific, and
> >>>> because the register is also used to set the PDM value, it is
> >>>> simpler to use a regmap-based syscon to deal with it.
> >>>>=20
> >>>> This time, I'm removing the PDM driver from the submission
> >>>> and submitting the PWM alone. The PDM was written as a misc
> >>>> driver, but had some design issues, so for now I'm proposing
> >>>> to merge the PWM only.
> >>>>=20
> >>>> The series is based on v3.19-rc3. If at all possible I'd like
> >>>> to see this merged for v3.20.
> >>>>=20
> >>>=20
> >>> Thierry,
> >>>=20
> >>> Any comments on this? Any chance we merge it in time for
> >>> v3.20? It's -rc5 already and I've started to worry.
> >>>=20
> >>=20
> >> Thierry,
> >>=20
> >> I'm very sorry to be so bothering, but I got no news from you and
> >> it's -rc6 already. I'd say I'll resend this series to Andrew
> >> Morton, hoping we can merge this for v3.20.
> >>=20
> >> Please let me know if you'll be able to pick this.
> >=20
> > I can pick it up if you make up your mind about the license. The
> > header comment says GPL v2 or later, but MODULE_LICENSE has "GPL
> > v2", which does not include the "or later" part.
> >=20
>=20
> License should be GPL v2, sorry about that. Need me to fix it and
> resend or can you amend it before pushing this?

I've fixed it up.

> > Also you're making it especially difficult to build-test by not=20
> > providing even the basic bits of your SoC support first. All even=20
> > linux-next seems to have for the Pistachio SoC is the addition of
> > a compatible string to the dw-mmc driver.
> >=20
>=20
> Well, we've added COMPILE_TEST for precisely this reason, so you only
> need to select COMPILE_TEST on any arch and you'll be able to build
> test the driver.

I'm not too big a fan of COMPILE_TEST. Sometimes build errors happen
only on one architecture, so if I build test your driver for ARM I may
miss issues and people will later complain to me that my tree broke
their build. So I prefer building on the target architecture if at all
possible.

> > I'll take the PWM driver, but I'll assume that you'll eventually
> > have more pieces available, in which case I'd appreciate a note so
> > I can update my build scripts.
> >=20
>=20
> If you can pick it, it would be great. I understand it's hard to
> accept patches for drivers, when there's little testing possibilities.
> But on the other side, isn't it a positive thing that a vendor is
> pushing drivers this early?

I wonder what's keeping the basic SoC support from being merged. As it
is the driver is completely unused, so I'm merging dead code. I'm going
to trust Andrew when he says that he plans on merging the SoC bits soon
so it's okay for now.

The problem with merging drivers first is that you have no possibility
of testing them in an upstream environment. You can't even test them
yourself even if you have local patches to make things actually boot.
I've seen that lead to unnecessary churn later on.

Yes, vendors contributing early is a good thing, but submitting code
that can't be tested in an upstream environment isn't very useful. You
can never be entirely certain that it's going to work before you have
the basic SoC support merged first.

Thierry

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUy2pMAAoJEN0jrNd/PrOhO/cP/3a3tvOHwO1J0gyVeI9E0HGY
y+uyuwjsYeU+nfvyZrO6b1WaGK2r6g+CX5NKY9iv/CWNQ5AH0tk9k9tmus8vfcbd
qp7ahswVe3BN0QJpvqCNOTA/8dwtWEzdMWXqZ51mgZbsy0gk2drfzAsuMT6JWwBk
8bEFVNnl+KGVT5yIaBVHZCnsx/vzbt230XDGrEwcKx9LzzqSB1mUOd7aetu602VQ
RrQC1ODoB/Drt75I4pPZoNJfnBUYhTxTmfJ6R9QXqLtNn0gl3Fbxlie4Irty0ZBb
2tfg3oytSfT/Jog2LtsfQctR/pPNxxxODuAYKfCTA41WNmQrwS81kZ3BwuRdHMVp
EAnIkz/InS//C2fnsbTSX6ITFmNFrXR1JcnaO9UwnXioHOAjxz5qbUjOnPmMUyOE
k8xR+WWfauWhUibClrn/ZwDFqYir7twaj+GaVzwTj10ymiNSc0L7OkEj/4l1pmHX
1k9mueUKevHnhn5lll8wa4jDyTm3LSgZA6XoQSOtDzLenbsQ8YwneZJBUO5y5lZH
VGJgydQ+VAJPzd5rYkyDaKoVXy6Rcknt6Gip2foU/fydC7x3ADWshoF0nvoraNv1
bim7XgROK2zRZxukJqcIIKXHSNvTt9s+NBBko1XmCBbhkDdeE4obLafKeyQi/XRT
r37SlSonvxT3WsTowFsZ
=2+Mh
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
