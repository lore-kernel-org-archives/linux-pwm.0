From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH 0/3] pwm: bcm2835: improve clock handling
Date: Tue, 15 Dec 2015 10:24:44 -0800
Message-ID: <87k2of4ljn.fsf@eliezer.anholt.net>
References: <1449010541-3767-1-git-send-email-stefan.wahren@i2se.com> <2004478620.33734.6de503e6-02cb-4cce-af2d-c2614efc234a.open-xchange@email.1und1.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from gabe.freedesktop.org ([131.252.210.177]:33969 "EHLO
	gabe.freedesktop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965147AbbLOSYr (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 15 Dec 2015 13:24:47 -0500
In-Reply-To: <2004478620.33734.6de503e6-02cb-4cce-af2d-c2614efc234a.open-xchange@email.1und1.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>, Lee Jones <lee@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-pwm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Remi Pommarel <repk@triplefau.lt>

--=-=-=
Content-Type: text/plain

Stefan Wahren <stefan.wahren@i2se.com> writes:

>> Stefan Wahren <stefan.wahren@i2se.com> hat am 1. Dezember 2015 um 23:55
>> geschrieben:
>>
>>
>> With the upcoming PWM clock support the pwm-bcm2835 should take
>> more care about the clock handling. But this patch series doesn't
>> depend on these clock driver changes.
>>
>> Stefan Wahren (3):
>> pwm: bcm2835: calculate scaler in pwm_config
>> pwm: bcm2835: prevent division by zero
>> pwm: bcm2835: fix email address specifiction
>>
>> drivers/pwm/pwm-bcm2835.c | 18 ++++++++++++------
>> 1 file changed, 12 insertions(+), 6 deletions(-)
>>
>
> gently ping

Thierry, do you want to fold in my r-bs and apply, or should Stefan
resend with them?

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWcFrsAAoJELXWKTbR/J7oRX4QAKuqYLprJHlOTYKWohMyq+fI
WlNSNx5kmF6FW7wCYq3fXF4aN2QaZmLsQVpgutGjFG2npQhnd2oteXEfz0WchIxr
lUQNjsK7PuhVB9WWFXMjhQwY249pKukXMM2iHU8FViFw7dyZLbftN9rrv7BDL9j2
pEqS6baLhPkCB8vl/f/SV6BcSu9kVq5udBAuV9H11fqJ8gP9F3mIOJ4T+1FWN6mr
HZzFJ7wZkcFXX8xhZZjCh33xyhctSM7oSJ2CGMZ/sJ+Mpg9N3T1+sh/sjIiCWNiV
+K/7NOt63DBByQ+PR/82eZFZoQ0IBYkkSLonbCcZoYRae/UojR17Bu4Sw+9A82ce
JQdXptSCcJ7ymvxCNdMsReBFVNUqxSzvx/AGbLtblw/sxjcvBpObXRzfrAwHxmL5
YCwT/lYhqwTDDAqpjmvBdVutLQuMDGTm9caT+/qQX8Lbr1xyuvULdo89D7Rpactv
3XLroyAsRRpKczI0ukCY7xZDNk7+xe6rjwbRQ3gtZX36KnlOMxB5+fnRicgOxnk4
WkokuAu7XwazmkqGclvS62nCWhgl13KBEBB9o5r/n09DERbBjZLDRwi44L0O8Y/6
f7dWfh9x3tFOYa+agL/wjz6ByRNdDlvxXK3cDgAx9ZEtjnmUN9+BsIInWMA+k4Uv
BmBU2qLSoaBUOSEu7yb5
=QaRD
-----END PGP SIGNATURE-----
--=-=-=--
