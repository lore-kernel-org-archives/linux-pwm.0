From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: PWM DMA interface
Date: Wed, 18 Jun 2014 00:54:05 +0200
Message-ID: <20140617225401.GA25525@mithrandir>
References: <CFBB4FD9.4313A%gordon@raspberrypi.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:60554 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755944AbaFQWyI (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Jun 2014 18:54:08 -0400
Received: by mail-wg0-f46.google.com with SMTP id y10so23393wgg.29
        for <linux-pwm@vger.kernel.org>; Tue, 17 Jun 2014 15:54:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CFBB4FD9.4313A%gordon@raspberrypi.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Gordon Hollingworth <gordon@raspberrypi.org>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 09, 2014 at 10:49:46AM +0000, Gordon Hollingworth wrote:
> Hi,
>=20
> I've been writing a driver that uses the PWM to talk to devices that
> communicate through a pwm like signal.  To achieve this some devices have
> a dma interface that you can stream data at to the pwm...
>=20
> We use something similar to this on Raspberry Pi to do audio output, we
> use the PWM interface to output a 'stream' of audio data which is
> subsequently filtered (RC filter) to give an audio output.

What kind of audio data is this? Is it able to play back any arbitrary
audio signal?

Thierry

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJToMcJAAoJEN0jrNd/PrOhiwwP/2wR9adHBx8esQuZ3F32F0O1
G1Vs2UV8Vm+r+2ZJlUuuKvIUIWLqfvs+NhXzsPzm8UUHlex7Kt1reE3W8fuB4nZ+
H5oxnrZbYKBBHZ10c8s/upI+hzjYYL1dzVbQKFpl8LXAaM9PIRnZGKAgpvmnxbrE
nq56RnHLFkgQSZx0fuCd6LXOwPyMvXQAXHKu0yN3BgGiXvx9BJwCPcO9c7ZuVsBv
2x5V/eqH29gF96WITvdjjmLUD+0WDWgeQERgE7RbzBAAJdDnjgD6Cxavx0ldyIEw
T8jw1LW7OPCEfZ9qbMOQ/XDgGJFnurj8y0qQpX/YYB07o0MI2Kw3QIVnI8VkLYec
p82SEkZ/D7QtQYVi8nDnbBo/cJntuwakIny9W5K/oU1TgV1zvnDwvNmZuuaZUtzu
1gpcs1Xipw4RMjKxd+/2KWORDVvgKUBmp28H3bcVBjan+GZWub6ZH8VnM3AGfthl
df0WZe8o4t3jv7HcPd+TYiMosLkbkQK//6mUFqnU5XNisNQB2p5T47rcjBPj0YLx
bTVeMFdQJjM8uGnvG+lq0RH1R8YGzKqXhQa6eIMlBvMsW/0xu5kleuFtO0ivdcuL
RL6UH1o9mRG38/NC+zxN7QLRLJ0ddrJdWzT9oeJ7MJ+6zNvzbymEOofDG0jDnDye
KNdZvDVbtl4F1vvzZom/
=zZ5f
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
