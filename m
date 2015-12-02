From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH 2/3] pwm: bcm2835: prevent division by zero
Date: Wed, 02 Dec 2015 11:43:39 -0800
Message-ID: <87lh9c8wlw.fsf@eliezer.anholt.net>
References: <1449010541-3767-1-git-send-email-stefan.wahren@i2se.com> <1449010541-3767-3-git-send-email-stefan.wahren@i2se.com> <87h9k1yd2z.fsf@eliezer.anholt.net> <565F259D.6060905@i2se.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from gabe.freedesktop.org ([131.252.210.177]:33719 "EHLO
	gabe.freedesktop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154AbbLBTnl (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Dec 2015 14:43:41 -0500
In-Reply-To: <565F259D.6060905@i2se.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>, Thierry Reding <thierry.reding@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>
Cc: Remi Pommarel <repk@triplefau.lt>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org

--=-=-=
Content-Type: text/plain

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Am 02.12.2015 um 00:16 schrieb Eric Anholt:
>> Stefan Wahren <stefan.wahren@i2se.com> writes:
>>
>>> It's possible that the pwm clock become an orphan. So better
>>> check the result of clk_get_rate in order to prevent a division
>>> by zero.
>> How would we lose our clock when we're keeping the clock enabled from
>> driver probe until remove?
>
> It's not the problem that we lose the clock inside this driver. The pwm
> clock could be initial assigned to a unregistered parent clock like "GND".
>
> I'm refering to this discussion:
>
> http://lists.infradead.org/pipermail/linux-rpi-kernel/2015-November/002603.html

I actually would have expected that the prepare would error out on a
clock with no rate set.  Interesting.  This seems like a good safety
measure, so this one is also:

Reviewed-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWX0nrAAoJELXWKTbR/J7ofAoP/jgW5Gd2/w7YJNTJ9YKJvECn
S9AQb/1xbU/12Ovu3QVThEfvuSm8sjz+UOIlh+Ii3/ZLebaMab+owQgGJPUgxvCE
z0+cK/DL4j6xdSzBkNYFshuzBZzonyY5qr5Gyiyo+Ql3ISXQs7RAq0jRRo5I9xla
glRXOwswD+zegtQ54k2br/IuSBv62sqXLF7B6CA0ALoeuJlIB3Prx/81JrAt+1Is
gViy8hbKXvcld5TCpdlvLkMPbS0jWMjnJWEeOlAc05LgPsxlOPeF4QwNlN0LwdMg
bx5jN1guZEiRqhTdn/WqS28jojSYGuzrjoUoP8DHFvIy/mJHLoPzwz7kKOWnUs9B
iQuKMC59nCnoEsYwWuk6DVscjG+lLjj1Bv0qauwPlpeBWeKX/1pBHAPZRirbrYaN
HEr8KcLYCGlw/tXdPksLLQkOjmf/6b7N4dKTfbldf4mAdXd8o6oxrvQzNkn1DExX
PxKqI/pob2KpCNXt20FoNxX0R7wxBE+dwFmjg9/UtUA3J6J2vTHCb77zUgut52x9
0cNNNo/aHWBbFMIyRUTjmwz+Dm0BSkBMgWi+SAErhd5YYvXWwpI+bR8q46Zgmm6J
y7S7xOqvJ+EMSlik4i1ftJ7CZa+d/PBSaNkic0tlB+sjMbBrfinPNNr1fkvl8ioK
cBetq/MblPyd+50ZVSzw
=07Hv
-----END PGP SIGNATURE-----
--=-=-=--
