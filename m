From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 11/12] ASoC: tegra: register dependency
 parser for firmware nodes
Date: Mon, 13 Jul 2015 16:42:55 +0100
Message-ID: <20150713154254.GH11162@sirena.org.uk>
References: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
 <1435743667-11987-12-git-send-email-tomeu.vizoso@collabora.com>
 <20150701173802.GW11162@sirena.org.uk>
 <CAAObsKDsEuDS46rW9CMuviDEDV-OVXe5q-kiWmw0D_n2D3Tf5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xZKIQynyWHxCFrdv"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAAObsKDsEuDS46rW9CMuviDEDV-OVXe5q-kiWmw0D_n2D3Tf5A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux PWM List <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org


--xZKIQynyWHxCFrdv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 13, 2015 at 02:10:45PM +0200, Tomeu Vizoso wrote:
> On 1 July 2015 at 19:38, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > On Wed, Jul 01, 2015 at 11:41:06AM +0200, Tomeu Vizoso wrote:

> >> +static void tegra_max98090_get_dependencies(struct fwnode_handle *fwnode,
> >> +                                         struct list_head *deps)
> >> +{
> >> +     add_dependency(fwnode, "nvidia,i2s-controller", deps);
> >> +     add_dependency(fwnode, "nvidia,audio-codec", deps);
> >> +}

> > Why is this all being open coded in an individual driver (we already
> > know about and manage all these dependencies in the core...)?  If we're
> > going to do this I'd expect the interface for specifying DT nodes to the
> > core to be changed to support this.

> Are you thinking of changing drivers to acquire their resources
> through Arnd's devm_probe (only that the resource table would have to
> be in struct device_driver)?

> https://lkml.kernel.org/g/4742258.TBitC3hVuO@wuerfel

No, I'm looking at how we already have all the "did all my dependencies
appear" logic in the core based on data provided by the drivers.

--xZKIQynyWHxCFrdv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVo9x+AAoJECTWi3JdVIfQCtwH/iR0OWw9MmX0rTpPvdi+DKPm
GHa0Sy8ieGKrBj60HzGLfLWerctXgSsB/dFWytfnpg4ebqe3Yc4TIcvADmbcA84L
4nq+I73X1bB9XrAd6+DEAAZ3pWdInbgw+P+VBdZJAmFHaY7pg7SeQmZr4xs3vaPh
6awa7eHWto27IT7zrOLHy12bBcFwmWZTQ/qh4XMWUPMc30/mfUoGBFzw+YokJGnw
sFv3JkWM7bXEDdv2y1Vd39730mDC3K8dCMadzDBIcgfECKUR2/Gmh0vxttkhyy6d
jTa4et1Urk1BsEoVSTT70QFvrvMveGGfFO7tXOD9qWE96pV7B6yIYEhjEne0Eg4=
=Q8CS
-----END PGP SIGNATURE-----

--xZKIQynyWHxCFrdv--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
