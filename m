From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 2/3] pwm: meson: Add clock source configuration for Meson
 G12A
Date: Tue, 23 Apr 2019 11:35:49 +0200
Message-ID: <dafeb987-b4e2-3830-7efe-dfe7eb1ce309@baylibre.com>
References: <20190412092337.6941-1-narmstrong@baylibre.com>
 <20190412092337.6941-3-narmstrong@baylibre.com>
 <CAFBinCA3iFSW4K8FJN913CcsxM4YFc2Of9Ldpn7230Ss427mMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFBinCA3iFSW4K8FJN913CcsxM4YFc2Of9Ldpn7230Ss427mMA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, baylibre-upstreaming@groups.io, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On 13/04/2019 13:33, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Fri, Apr 12, 2019 at 11:24 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> For PWM controller in the Meson G12A SoC, the EE domain and AO domain
>> have different clock sources. This patch tries to describe them in the
>> DT compatible data.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/pwm/pwm-meson.c | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
>> index 2b03938039b6..46287cc8a0eb 100644
>> --- a/drivers/pwm/pwm-meson.c
>> +++ b/drivers/pwm/pwm-meson.c
>> @@ -434,6 +434,15 @@ static const struct meson_pwm_data pwm_axg_ao_data = {
>>         .num_parents = ARRAY_SIZE(pwm_axg_ao_parent_names),
>>  };
>>
>> +static const char * const pwm_g12a_ee_parent_names[] = {
>> +       "xtal", "hdmi_pll", "fclk_div4", "fclk_div3"
>> +};
>> +
>> +static const struct meson_pwm_data pwm_g12a_ee_data = {
>> +       .parent_names = pwm_g12a_ee_parent_names,
>> +       .num_parents = ARRAY_SIZE(pwm_g12a_ee_parent_names),
>> +};
>> +
>>  static const struct of_device_id meson_pwm_matches[] = {
>>         {
>>                 .compatible = "amlogic,meson8b-pwm",
>> @@ -455,6 +464,14 @@ static const struct of_device_id meson_pwm_matches[] = {
>>                 .compatible = "amlogic,meson-axg-ao-pwm",
>>                 .data = &pwm_axg_ao_data
>>         },
>> +       {
>> +               .compatible = "amlogic,meson-g12a-ee-pwm",
>> +               .data = &pwm_g12a_ee_data
>> +       },
> the PWM part is fine for me
> 
>> +       {
>> +               .compatible = "amlogic,meson-g12a-ao-pwm",
>> +               .data = &pwm_axg_ao_data
>> +       },
>>         {},
> but I'm not sure about "amlogic,meson-g12a-ao-pwm":
> the public S922X datasheet from Hardkernel [0] section 6.6.1.2 "AO
> Clock Tree" (page 107) mentions two different clock sources for the AO
> PWMs:
> - AO PWM A and B has parents xtal, aoclk81, fclk_div4 and fclk_div5
> (pwm_axg_ao_data has the first two parents swapped)
> - AO PWM C and D only have xtal and aoclk81 as parents

You are right, and it's the same on G12A.

> 
> regarding the clock parents:
> I'm not sure whether pwm_axg_ao_data is wrong, G12A is different from
> G12B or the G12B datasheet is "correct". can you please list what you
> have tested so far and confirm that the parents you are using are
> "correct"

You were right, we need 2 different compatibles here...

> 
> regarding the compatible string "amlogic,meson-g12a-ao-pwm":
> if there are two different AO PWM modules, should we name it
> differently, for example by splitting this compatible string into:
> - "amlogic,meson-g12a-ao-pwm-ab" (with parents: xtal, aoclk81,
> fclk_div4 and fclk_div5)
> - "amlogic,meson-g12a-ao-pwm-cd" (with parents: xtal and aoclk81)
> 

Exact

> 
> Regards
> Martin
> 
> 
> [0] https://dn.odroid.com/S922X/ODROID-N2/Datasheet/S922X_Public_Datasheet_V0.2.pdf
> 


Thanks,
Neil
