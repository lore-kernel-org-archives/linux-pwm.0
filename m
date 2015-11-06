From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 08/10] pwm: core: add pulse feature to the PWM framework
Date: Fri, 6 Nov 2015 17:05:47 +0100
Message-ID: <20151106160547.GF8418@ulmo>
References: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
 <1445895161-2317-9-git-send-email-o.schinagl@ultimaker.com>
 <20151106151816.GD8418@ulmo>
 <563CCB6E.2090206@ultimaker.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MZf7D3rAEoQgPanC"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <563CCB6E.2090206-U3FVU11NWA554TAoqtyWWQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Olliver Schinagl <o.schinagl-U3FVU11NWA554TAoqtyWWQ@public.gmane.org>
Cc: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Olliver Schinagl <oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--MZf7D3rAEoQgPanC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2015 at 04:46:54PM +0100, Olliver Schinagl wrote:
> Hey Thierry,
>=20
> On 06-11-15 16:18, Thierry Reding wrote:
> >On Mon, Oct 26, 2015 at 10:32:39PM +0100, Olliver Schinagl wrote:
> >>From: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
> >>
> >>Some hardware PWM's have the possibility to only send out one (or more)
> >>pulses. This can be quite a useful feature in case one wants or needs
> >>only a single pulse, but at the exact width.
> >>
> >>Additionally, if multiple pulses are possible, outputting a fixed amount
> >>of pulses can be useful for various timing specific purposes.
> >I see how theoretically this would be nice to have. But I'm reluctant to
> >merge this feature if there aren't any users. What drivers in the kernel
> >would want to use this feature? Are there new drivers being worked on
> >that will need this?
> I should have brought this up as to why I added this, I'm working on a
> stepper driver framework (inspired by the pwm framework actually) and
> rotating moters by x degree's you do by sending pulses, using controlled
> pulses (timing wise) you can precisely move stepper motors. Yes we can do
> this reasonably accurate in software, but doing it in hardware is so much
> nicer.

So is this going to be a kernel framework for stepper motors? If you say
you rotate the motors by sending pulses, doesn't that mean that the PWM
framework with pulse support would be enough? Or are there dedicated
stepper chips that you plan to support, with PWM + pulses being the
fallback for when you don't have one of those chips?

> >>* pwm_pulse_done()	an internal function for drivers to call when
> >>			they have completed their pre-configured number
> >>			of pulses
> >>* pwm_is_pulsing()	tells the callers if the pwm is busy pulsing,
> >>			yielding a little more information than just
> >>			pwm_is_enabled()
> >Similarily, I'd think that once the PWM is done executing the series of
> >pulses that it was configured for it would be automatically disabled. A
> >consumer could then simply use pwm_is_enabled() and drivers could call
> >pwm_disable() on their PWM to mark them as disabled when they're done
> >pulsing.
> I agree, pulseating can be dropped too as we know that a) the pulse flag =
is
> set, b) we are enabled. But I'm not sure now if the flag is exported to
> sysfs, in any case, sysfs should just check the pulseating flag?

Can't you derive that information simply by looking at the enable and
pulses attributes? If enable =3D=3D 1 and pulses > 0 you know the PWM is
pulsing. If enable =3D=3D 1 and pulses =3D=3D 0 you know it's in regular mo=
de.

Thierry

--MZf7D3rAEoQgPanC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWPM/bAAoJEN0jrNd/PrOhdu0P/0n4cAn0ExkukE0v5sTNngWR
pDA5ZF+B8f5BdGibchFOEQLPapYSeRLd0yHTGyK22wHNQ+y1/mREofvbEjP3Aaa3
z3rD6cv69GsYoXSxrElXvEW1GpjQLPGT3NdpO6I299lz2wB3PoH95Tm7zw5nFt7I
BFKkPAT2DjCSy/E6X3ay0L0g8nP0P9oEfI66MSFcGbzDvvBIubzWBGXKL/24/J/A
Tvt9JO5S61G9d6FmrQ2MTq35kKgFrIvhpbFO1JXnDDQjp9aSURL5uPcd/8cHt4Xk
2gHWCyOYi5/F1oVMgLty03ZBlETgUYAyA42OEVwpERRbM5vfImweJqzJmW8c2Vdu
GMqbww6gtjb5EJx7Z9PoUN7FrsgRZqxMpN7IXeo4g6YerM2wYFSVClDBG9cayIOu
jhfr64uDZqTxbwXOOcu3emuhOFZu7wlihele+lEhYcE9YF9VYhz1ZlSxsDYSSfYb
EHLkRKGkFUI0M6Miq2epm3/uBIYHyB4RKwtvrU3OWWhuFHWZrt/2lWZGZp/tfX2p
9RYHYzdOyIQeCR2+9phUjFFjGiJUxoE691wDvrrB6e6b3yK1W35ebVOmqcTVR/It
lsX0THOM163rSNBB3ofh346ZOCxCbM6OZSJazuZ6P5fubt/NyE+0bfBByEB6rUWY
SScR1VztDCSIBo2fnuWD
=9/Ry
-----END PGP SIGNATURE-----

--MZf7D3rAEoQgPanC--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
