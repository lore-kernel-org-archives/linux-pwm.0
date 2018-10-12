From: <Claudiu.Beznea@microchip.com>
Subject: Re: [RESEND PATCH v5 8/9] pwm: add documentation for pwm push-pull
 mode
Date: Fri, 12 Oct 2018 13:05:50 +0000
Message-ID: <f4a1f9e3-b3a8-2847-f13e-bb07dab400e6@microchip.com>
References: <1535461286-12308-1-git-send-email-claudiu.beznea@microchip.com>
 <1535461286-12308-9-git-send-email-claudiu.beznea@microchip.com>
 <20181012121552.GE31561@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181012121552.GE31561@ulmo>
Content-Language: en-US
Content-ID: <2122BCBB722E1A45B16B7E23800C80D3@namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, alexandre.belloni@bootlin.com, shc_work@mail.ru, corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org



On 12.10.2018 15:15, Thierry Reding wrote:
> On Tue, Aug 28, 2018 at 04:01:25PM +0300, Claudiu Beznea wrote:
>> Add documentation for PWM push-pull mode.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>  Documentation/devicetree/bindings/pwm/pwm.txt |  2 ++
>>  Documentation/pwm.txt                         | 16 ++++++++++++++++
>>  include/dt-bindings/pwm/pwm.h                 |  1 +
>>  3 files changed, 19 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentati=
on/devicetree/bindings/pwm/pwm.txt
>> index 7c8aaac43f92..6a60c0fca112 100644
>> --- a/Documentation/devicetree/bindings/pwm/pwm.txt
>> +++ b/Documentation/devicetree/bindings/pwm/pwm.txt
>> @@ -49,6 +49,8 @@ Optionally, the pwm-specifier can encode a number of f=
lags (defined in
>>  - PWM_MODE_COMPLEMENTARY: PWM complementary working mode (for PWM chann=
els
>>  with two outputs); if not specified, the default for PWM channel will b=
e
>>  used
>> +- PWM_MODE_PUSH_PULL: PWM push-pull working modes (for PWM channels wit=
h
>> +two outputs); if not specified the default for PWM channel will be used
>=20
> What if somebody has this in the DT:
>=20
> 	PWM_MODE_COMPLEMENTARY | PWM_MODE_PUSH_PULL
>=20
> which one takes precedence, or do we reject it?

The first valid one will be selected.

In patch 1/1 from this series, changes added to of_pwm_xlate_with_flags()
function, there is this code:

+		for (modebit =3D PWMC_MODE_COMPLEMENTARY_BIT;
+		     modebit < PWMC_MODE_CNT; modebit++) {
+			unsigned long mode =3D BIT(modebit);
+
+			if ((args->args[2] & mode) &&
+			    pwm_mode_valid(pwm, mode)) {
+				pwm->args.mode =3D mode;
+				break;
+			}
+		}

And since the modes bits are defined as follows:

enum {
	PWMC_MODE_NORMAL_BIT,
	PWMC_MODE_COMPLEMENTARY_BIT,
	PWMC_MODE_PUSH_PULL_BIT,
	PWMC_MODE_CNT,
};

in your proposed scenario: PWM_MODE_COMPLEMENTARY | PWM_MODE_PUSH_PULL
the PWM_MODE_COMPLEMENTARY mode will be selected since it is the first
valid one.

>=20
> Wouldn't it be preferable to either move the modes into an extra field
> within the flags field, or perhaps even add another field?

This approach was proposed in version 2 of this series and based on the
discussions I had with Rob Herring [1] I decided to use the remaining space
from cell specific to PWM flags.

Thank you,
Claudiu Beznea

[1] https://lkml.org/lkml/2018/1/22/655

>=20
> I guess since Rob's already acked this, that concern may be unfounded.
>=20
> Thierry
>=20
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>=20
