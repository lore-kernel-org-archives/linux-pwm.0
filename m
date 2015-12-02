From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH 2/3] pwm: bcm2835: prevent division by zero
Date: Wed, 02 Dec 2015 11:41:57 -0800
Message-ID: <87oae88woq.fsf@eliezer.anholt.net>
References: <1449010541-3767-1-git-send-email-stefan.wahren@i2se.com> <1449010541-3767-3-git-send-email-stefan.wahren@i2se.com> <CANLsYkzsFzhVVPo6iykExgbCd-4spJPusMCXxKstOw=CXfwQbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from gabe.freedesktop.org ([131.252.210.177]:33523 "EHLO
	gabe.freedesktop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790AbbLBTmA (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Dec 2015 14:42:00 -0500
In-Reply-To: <CANLsYkzsFzhVVPo6iykExgbCd-4spJPusMCXxKstOw=CXfwQbw@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Mathieu Poirier <mathieu.poirier@linaro.org>, Stefan Wahren <stefan.wahren@i2se.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, linux-pwm@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>, linux-rpi-kernel@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

--=-=-=
Content-Type: text/plain

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> On 1 December 2015 at 15:55, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>> It's possible that the pwm clock become an orphan. So better
>> check the result of clk_get_rate in order to prevent a division
>> by zero.
>>
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>> ---
>>  drivers/pwm/pwm-bcm2835.c |   10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
>> index 174cca9..31a6992 100644
>> --- a/drivers/pwm/pwm-bcm2835.c
>> +++ b/drivers/pwm/pwm-bcm2835.c
>> @@ -65,7 +65,15 @@ static int bcm2835_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>>                               int duty_ns, int period_ns)
>>  {
>>         struct bcm2835_pwm *pc = to_bcm2835_pwm(chip);
>> -       unsigned long scaler = NSEC_PER_SEC / clk_get_rate(pc->clk);
>> +       unsigned long rate = clk_get_rate(pc->clk);
>> +       unsigned long scaler;
>> +
>> +       if (!rate) {
>> +               dev_err(pc->dev, "failed to get clock rate\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       scaler = NSEC_PER_SEC / rate;
>
> Stefan,
>
> Please merge this code into patch 1/3.  That way it is done the right
> way the first time around.

They're separate changes and are good as separate patches.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWX0mFAAoJELXWKTbR/J7ocFQP/RL8neA1BOGt9YOvIOOgYg1y
C6H3MlhQiIDOALQyzT6xsKewpJKIrz2ynzIRO3YlkAK9CELJHbDIEs4E1o350li1
tZuq2D7+cj99/SGwzjRT9Vd+B8b0GSFULTbwex73bF3jqhtNZGKvj7kWILn2m93J
C5gCrowIwYqj+/emjmcXc3h+gPSAdelspITjkuDQe/E8DMHthqFAB9ZsDE8+Hueu
+ClURuvQRMyl6ORMtZFD2/aUTVppAeEwIWokDUMAnP3q8E4D5/7kWlmDz2kjonlO
1lpJGYBPA/0/VeJKWo7HSHuugNs+rQP/1siWsBDayPJlqHElpGvhac9BhgPITB3p
rJopG5TtkVjQrNRheVqSQ8q25q3yva/WXupPgcuqBBxHzLdmWTct+qKrzAQVVcfY
fmPdkouuPVcFAFErJHxY4WQgl+lzdRV9doK0NFDOrvf5RKHgh+clGZvraSD2W1Kp
K8ACMw+ujALXNurjkTSJ1A2YvCvFVb/by1h4wQnD7itQxLicPxCDVQnRwpH2hazV
KeRXWNSKcM7J+WbxSTBqpDVIBcSI2nQ7A6Puzaq3Oho/poUWNX716i2C0O9Clg31
Ywjsaj2Ai0e6ys4okPxbDiMMYu2L+zhBk2s6MT20+UyOPqEIYT6RowIFJXYdcJci
eejMUsSl3geDuoVlXyx7
=vZ72
-----END PGP SIGNATURE-----
--=-=-=--
