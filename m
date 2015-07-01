From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 11/12] ASoC: tegra: register dependency parser for
 firmware nodes
Date: Wed, 1 Jul 2015 18:38:02 +0100
Message-ID: <20150701173802.GW11162@sirena.org.uk>
References: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
 <1435743667-11987-12-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TcuvTDpCAASXpu1W"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1435743667-11987-12-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Thierry Reding <thierry.reding@gmail.com>, Takashi Iwai <tiwai@suse.de>, Stephen Warren <swarren@wwwdotorg.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-tegra@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>
List-Id: linux-pwm@vger.kernel.org


--TcuvTDpCAASXpu1W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 01, 2015 at 11:41:06AM +0200, Tomeu Vizoso wrote:

> +static void tegra_max98090_get_dependencies(struct fwnode_handle *fwnode,
> +					    struct list_head *deps)
> +{
> +	add_dependency(fwnode, "nvidia,i2s-controller", deps);
> +	add_dependency(fwnode, "nvidia,audio-codec", deps);
> +}

Why is this all being open coded in an individual driver (we already
know about and manage all these dependencies in the core...)?  If we're
going to do this I'd expect the interface for specifying DT nodes to the
core to be changed to support this.

--TcuvTDpCAASXpu1W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVlCV6AAoJECTWi3JdVIfQ9sQH/07qCQICx8rYy7I6jC+6lWam
k0oQM1iJtoGIzxrnjZ3kPkumKA1N/p1bXAx3NVcmrD7KcOhALqe50qpheQ+CmVOZ
LYAhUrbBYuPUBBqd9hsT7ZfLnAM9/jHCI04ch/Z8qo2khMwXmPPcm4tQeijJLLki
dpvepRs8pRozlpKkQroJJQ1zleI/D64IxnqRbKauI+3MPBxyZeUe9ozjZI8VjxWq
7N/AUIKachCgud0DNxjtdmsNMh6teCXQeV5YOGqcOsFHXQodpiRozw+2/As5N/Te
fllk/BbgQInsWyI9MG0D69+KvSgNkBB+k4YODNzV7AKYE3IqKxJdDP+C+HKeubg=
=TvF/
-----END PGP SIGNATURE-----

--TcuvTDpCAASXpu1W--
