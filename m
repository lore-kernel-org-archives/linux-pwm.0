From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 01/12] device: property: delay device-driver matches
Date: Fri, 17 Jul 2015 01:06:22 +0100
Message-ID: <20150717000622.GH1602@sirena.org.uk>
References: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
 <1435743667-11987-2-git-send-email-tomeu.vizoso@collabora.com>
 <20150716202312.GD11162@sirena.org.uk>
 <CAJZ5v0gMx=DA0f8i9wdMvkYTyOhr0WKh-T6L7rjcxeaAjNMW3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CNfT9TXqV7nd4cfk"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gMx=DA0f8i9wdMvkYTyOhr0WKh-T6L7rjcxeaAjNMW3g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-gpio@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-pwm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-pwm@vger.kernel.org


--CNfT9TXqV7nd4cfk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 17, 2015 at 01:41:16AM +0200, Rafael J. Wysocki wrote:
> On Thu, Jul 16, 2015 at 10:23 PM, Mark Brown <broonie@kernel.org> wrote:
> > On Wed, Jul 01, 2015 at 11:40:56AM +0200, Tomeu Vizoso wrote:

> > I have to say I'm still not 100% clear that special casing platform
> > devices makes sense here - I can see that platform devices are usually
> > the first devices to instantiate but there are other kinds of devices
> > and it's not obvious what the benefit of specifically picking out
> > platform devices as opposed to just deferring all devices is.

> Some existing devices cannot be deferred without redesigning things quite a bit.

OK, that should go in the changelog then - right now it's just a bit
obtuse why we're doing this (and as you say it's a bit awkward).  Now
you mention this I'm thinking that some of the affected devices might be
platform devices on some systems, IOMMUs spring to mind for example...
they're one of the main bits of the system I'm aware of that still rely
on probe ordering and they do tend to be platform devices.

> What I was talking about, though, was to use an opt-in mechanism for
> that which could be set for all platform devices, for example, by
> default, but it might be set for other bus types too if that's useful.

Sure, I got that and do agree with you that a mechanism like you suggest
would be good.  I just wasn't clear why we were targetting platform
devices in the first place.

--CNfT9TXqV7nd4cfk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVqEb6AAoJECTWi3JdVIfQ6igH/1lfzgngw+QMPD3PzShllj57
i/HPqcOa7NFybef7ZM2t00i3/PCAPOhg2EsaPaV34euzZ57FZX0DvS89+1K1q3sw
h+u95jS4c8GMJnO9gAnQZ1u5S6OM40j/livOl/HaVb0qUSIFwEeRHbJfW3uJ/wZf
3phgAXmVjPQRqJS054a/CGEyU2lwZW+4enxtBs49TbY1EHE8TbQIG9EM5kqAu23I
t4Y5+RDaft1SNXacAjjc0cwYIFY9xh5UnYDLDhNc1mabklu9selE0PKhgS8PUkl5
X+D87P00jPDUd99qbILBZhRqIw+72BKECQ/ddJCQXIW2u0pjJc1W81iYl/LF2bw=
=w0V2
-----END PGP SIGNATURE-----

--CNfT9TXqV7nd4cfk--
