From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v8 0/2] Imagination Technologies PWM support
Date: Fri, 30 Jan 2015 11:26:13 +0100
Message-ID: <20150130102612.GE16744@ulmo>
References: <1420826088-13113-1-git-send-email-ezequiel.garcia@imgtec.com>
 <54BE3369.9000802@imgtec.com>
 <54CA6089.50505@imgtec.com>
 <20150130091832.GA16744@ulmo>
 <CAL1qeaH77fJuh8fM1tKJz0bizni1sErCy=EwZTzV=EY10dX9iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VUDLurXRWRKrGuMn"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL1qeaH77fJuh8fM1tKJz0bizni1sErCy=EwZTzV=EY10dX9iA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--VUDLurXRWRKrGuMn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2015 at 09:50:46AM +0000, Andrew Bresticker wrote:
> > Also you're making it especially difficult to build-test by not
> > providing even the basic bits of your SoC support first. All even
> > linux-next seems to have for the Pistachio SoC is the addition of a
> > compatible string to the dw-mmc driver.
> >
> > I'll take the PWM driver, but I'll assume that you'll eventually have
> > more pieces available, in which case I'd appreciate a note so I can
> > update my build scripts.
>=20
> FYI, I'm hoping to post Pistachio platform support for 3.21.

That'd be great. I can switch over to a proper defconfig then and not
jump through extra hoops to build test patches.

Also, I'm seeing a bunch of weird errors from building MIPS, mostly
things like this:

	  CC      net/ipv4/netfilter/arp_tables.mod.o
	{standard input}: Assembler messages:
	{standard input}: Warning: .gnu_attribute 4,3 requires `softfloat'

or this later on:

	mips-linux-gnu-ld: Warning: vmlinuz uses -mhard-float (set by arch/mips/bo=
ot/compressed/head.o), arch/mips/boot/compressed/decompress.o uses -msoft-f=
loat

This is essentially a gpr_defconfig (because it select MIPS_ALCHEMY,
which in turns pulls in COMMON_CLK that PWM_IMG depends on) and then
enabling MFD_SYSCON on top so that all dependencies are met.

What am I doing wrong?

Thierry

--VUDLurXRWRKrGuMn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUy1xEAAoJEN0jrNd/PrOh/b4P/ihE/Uu/De8WyqbYMUWFhBsJ
1b7Abs4OoYUZt8QoYf127Eohurt1Wg6oX0nh6sX8VD/5ypLswgi+f1iibO7uerQI
0Hsdl7J9s7mdES4LqQm0ew5ikyGl7ISbb2hQZbnmiSyGBCzr1pvgawemlYq+cL5c
6s7AVZ/qPct5JfD7xmUR6kWI5sMsYcFyRBdlWPIANf3FvjgIjRdtpQVkwCe0+8ZW
iWAILU0MAdwFxisjuC60QtuSa0KHPzMUsTGeIFgS4xg7YgP75DLM7dxPaU1R/9gn
31DeBiHc9g971OXAqbmZzsS+01GcuJPsIAJ6GvLFDGq1+MYD1sYeDniouN8GccFw
DPH9Y3raIdWo9G16HUdG7jL3Pvu58+8jnWCFHGBvciwX3WpfSVkHThSytWn2D/q6
rlgGBOLckurdf/Y+7FTHsUJIVI8xNhqHtceiOYGcqtHZU3UgKJqxYD7wnnAh3QLn
SCycBQRnxaxeOaiMz/LAImJtYlrgCz25cPk9u/kbsmmqatAMBN9P8V+J3JwTQ9cZ
9RQjVyqDMoPd0zakeWm73BPQoJCbWo05TE7kpgb5Gni3j9jHaVxqM7+pjKM0hIlt
m0wPnctRDG3MsqmIiGGrMfSl9F2f7C45wyR49UcT/1Kevgf84PkbXBerfsGXDmYz
3WNFw0QXVlmFVV1tWN9a
=t76U
-----END PGP SIGNATURE-----

--VUDLurXRWRKrGuMn--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
