From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 11/12] ASoC: tegra: register dependency
 parser for firmware nodes
Date: Tue, 14 Jul 2015 12:07:13 +0100
Message-ID: <20150714110713.GT11162@sirena.org.uk>
References: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
 <1435743667-11987-12-git-send-email-tomeu.vizoso@collabora.com>
 <20150701173802.GW11162@sirena.org.uk>
 <CAAObsKDsEuDS46rW9CMuviDEDV-OVXe5q-kiWmw0D_n2D3Tf5A@mail.gmail.com>
 <20150713154254.GH11162@sirena.org.uk>
 <CAAObsKAVY7-QpcRyT4juc2RyB+vqibvzKO7wFCT2VsL9R8bzPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="W8iFDApEu++Vn+WX"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAAObsKAVY7-QpcRyT4juc2RyB+vqibvzKO7wFCT2VsL9R8bzPw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux PWM List <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org


--W8iFDApEu++Vn+WX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 14, 2015 at 09:34:22AM +0200, Tomeu Vizoso wrote:
> On 13 July 2015 at 17:42, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > No, I'm looking at how we already have all the "did all my dependencies
> > appear" logic in the core based on data provided by the drivers.

> Sorry, but I still don't get what you mean.

I'm not sure how I can be clearer here...  you're replacing something
that is currently pure data with open coding in each device.  That seems
like a step back in terms of ease of use.

> Information about dependencies is currently available only after
> probe() starts executing, and used to decide whether we want to defer
> the probe.

> The goal of this series is to eliminate most or all of the deferred
> probes by checking that all dependencies are available before probe()
> is called.

Right, but the way it does this is by moving code out of the core into
the drivers - currently drivers just tell the core what resources to
look up and the core then makes sure that they're all present.

> I thought you were pointing out that the property names would be
> duplicated, once in the probe() implementation and also in the
> implementation of the get_dependencies callback.

Yes, that is another part of issue with this approach - drivers now have
to specify things twice, once for this new interface and once for
actually looking things up.  That doesn't seem awesome and adding the
code into the individual drivers and then having to pull it out again
when the redundancy is removed is going to be an enormous amount of
churn.

> A way to consolidate the code and remove that duplication would be
> having a declarative API for expressing dependencies, which could be
> used for both fetching dependencies and for preventing deferred
> probes. That's why I mentioned devm_probe.

Part of what I'm saying here is that in ASoC we already have (at least
as far as the individual drivers are concerned) a declarative way of
specifying dependencies.  This new code should be able to make use of
that, if it can't and especially if none of the code can be shared
between drivers then that seems like the interface needs another spin.

I've not seen this devm_probe() code but the name sounds worryingly like
it might be fixing the wrong problem :/

--W8iFDApEu++Vn+WX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVpO1gAAoJECTWi3JdVIfQnSAH+wT+w5R81fdOFtEt0wy01yaj
GshHYfsA3FUBcLolXKBfwdFn3xRd0MjjOaTZ3pcrPGoKZDNNUF+X41SNSxoeyFoc
biuYRxw7xpCeT1u7g7aAu/IHyFSXLH/UmW21mckH6JtmLh1wLNKDTNQTI2OFwFLY
tJKsMXHhAzJ1+nLWxXHpuVN7U+dtNstl+BjGMfXbJqaz8OmvEPkzusI+w5bVlUhL
+q0+AKvuqOYo2gDVlWL1ou2NTJfoubdWrmgquEG351VimQopSAR6feYiORUkwhVp
176VGZHUTgwpzQo4L2Y1nQkX8D47pHng85WnMEHUnMAYq87XhASkmmuaLaKQfg0=
=tRqQ
-----END PGP SIGNATURE-----

--W8iFDApEu++Vn+WX--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
