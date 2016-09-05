From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 1/4] pwm: Add support for Meson PWM Controller
Date: Mon, 5 Sep 2016 11:00:52 +0200
Message-ID: <20160905090052.GG3532@ulmo.ba.sec>
References: <1471880193-21879-1-git-send-email-narmstrong@baylibre.com>
 <1471880193-21879-2-git-send-email-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9Iq5ULCa7nGtWwZS"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1471880193-21879-2-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: carlo@caione.org, khilman@baylibre.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--9Iq5ULCa7nGtWwZS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 22, 2016 at 05:36:30PM +0200, Neil Armstrong wrote:
> Add support for the PWM controller found in the Amlogic SoCs.
> This driver supports the Meson8b and GXBB SoCs.
>=20
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/pwm/Kconfig     |   9 +
>  drivers/pwm/Makefile    |   1 +
>  drivers/pwm/pwm-meson.c | 528 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 538 insertions(+)
>  create mode 100644 drivers/pwm/pwm-meson.c

Hi Neil,

sorry for taking so long to review this. I had actually started to write
a review email since I had noticed a couple of slight oddities about the
driver structure (primarily this was about how channel-specific data was
split between struct meson_pwm_channel and struct meson_pwm_chip), but I
ended up making some changes to the driver in order to see what my
suggestions would look like, and if they would indeed improve things.
But once I had done that, I thought it a bit pointless to make that into
review comments and decided to just push what I had done and ask you to
take a look, and if you had no objections to the changes take the driver
for a spin to see if it still worked as expected.

One other thing I noticed is that your ->get_state() implementation only
reads the enable state, but from the looks of it it should be possible
to read period and duty cycle information from hardware as well. I'm not
going to reject the driver for that reason, just saying that it'd be
good to have that implemented sometime in the future.

I've pushed my modifications to the driver to the linux-pwm repository:

	https://git.kernel.org/cgit/linux/kernel/git/thierry.reding/linux-pwm.git/=
log/?h=3Dfor-next

Alternatively you can also take a look at the for-4.9/drivers branch,
but they're currently the same thing.

Thierry

--9Iq5ULCa7nGtWwZS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJXzTRCAAoJEN0jrNd/PrOheBMQAI4n9pQaAm7tyAeSl723FaSl
fadqlA+/Juzm71eghUmVDNM/xT7OQvJqDQr29r6xGblNAU3JftjQDMZ6RR3e1hJo
2z2L11kHfeJuHVgk8b08N3eM/POf1S2llMwxP5HteQ+MGUKbuiwQdV7nXRYjrFjc
hJVXw+js59m9arGk0MkolHWkNW3tGwbwIl7YVmG+vOidDLA8xIdbB0jQ6tuiA0/i
Cs9F/VXppk4XvDznH4UB3twQ9qb3KiOoX0Q7uID1X6heKW82w8kJ0igrIZeP4V1A
/JlK3KSnxHE+gKtoQLET2zydTG9s15lg67MtpOLaicQMfnMz63jVl5q+tj9PacL2
h0dy5y0rTBL2vlzCAYcEa1DoHISo76lVpvNheGPUjFnq7BfOvoC18gKiLdfz4tyk
pBozOkpRF3ZCPo5zFFkLzRpgtV2woepkqrPs+bmdgKgJzkVmAyFKeN77QrcGfD6y
sB+eGfNO5y2zW7PDGZaVBBpXkYt2xFdKqZfqJNieohM1ywdTtaFW5QWSlZEODbtX
tkMbuuT3R8kZ82D8ZTsZKlrRvH/lqIqu8XvNRKDwf+WAsFLoUvmhoeRIjH4v3ADe
Wa2iZLsUYhI4HB0QExjkKGo31EEEqFIJFIlJTeSkkEHeGVIOTXxuD59Y72vpCzda
3fmYMsjKqnkvT+Hs0j8l
=wyB7
-----END PGP SIGNATURE-----

--9Iq5ULCa7nGtWwZS--
