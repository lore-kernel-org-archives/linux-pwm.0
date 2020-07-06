From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 11/15] pwm: crc: Implement get_state()
 method
Date: Mon, 6 Jul 2020 23:05:20 +0200
Message-ID: <59babd32-9421-0b31-187f-ceff7c003f54@redhat.com>
References: <20200620121758.14836-1-hdegoede@redhat.com>
 <20200620121758.14836-12-hdegoede@redhat.com>
 <20200622075730.lenaflptqnemagff@taurus.defre.kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20200622075730.lenaflptqnemagff@taurus.defre.kleine-koenig.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Len Brown <lenb@kernel.org>
List-Id: linux-pwm@vger.kernel.org

Hi,

On 6/22/20 9:57 AM, Uwe Kleine-K=C3=B6nig wrote:
> On Sat, Jun 20, 2020 at 02:17:54PM +0200, Hans de Goede wrote:
>> Implement the pwm_ops.get_state() method to complete the support for the
>> new atomic PWM API.
>>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v3:
>> - Add Andy's Reviewed-by tag
>> - Remove extra whitespace to align some code after assignments (requeste=
d by
>>    Uwe Kleine-K=C3=B6nig)
>> ---
>>   drivers/pwm/pwm-crc.c | 29 +++++++++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
>> index 8a7f4707279c..b311354d40a3 100644
>> --- a/drivers/pwm/pwm-crc.c
>> +++ b/drivers/pwm/pwm-crc.c
>> @@ -119,8 +119,37 @@ static int crc_pwm_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
>>   	return 0;
>>   }
>>   =

>> +static void crc_pwm_get_state(struct pwm_chip *chip, struct pwm_device =
*pwm,
>> +			       struct pwm_state *state)
>> +{
>> +	struct crystalcove_pwm *crc_pwm =3D to_crc_pwm(chip);
>> +	struct device *dev =3D crc_pwm->chip.dev;
>> +	unsigned int clk_div, clk_div_reg, duty_cycle_reg;
>> +	int error;
>> +
>> +	error =3D regmap_read(crc_pwm->regmap, PWM0_CLK_DIV, &clk_div_reg);
>> +	if (error) {
>> +		dev_err(dev, "Error reading PWM0_CLK_DIV %d\n", error);
>> +		return;
>> +	}
>> +
>> +	error =3D regmap_read(crc_pwm->regmap, PWM0_DUTY_CYCLE, &duty_cycle_re=
g);
>> +	if (error) {
>> +		dev_err(dev, "Error reading PWM0_DUTY_CYCLE %d\n", error);
>> +		return;
>> +	}
>> +
>> +	clk_div =3D (clk_div_reg & ~PWM_OUTPUT_ENABLE) + 1;
>> +
>> +	state->period =3D clk_div * NSEC_PER_USEC * 256 / PWM_BASE_CLK_MHZ;
>> +	state->duty_cycle =3D duty_cycle_reg * state->period / PWM_MAX_LEVEL;
> =

> Please round up here.

Ok, I can fix that for the next version of this patch-set. Before I
post a new version of this patch-set, you have only responded to
some of the PWM patches in this set. Do you have any remarks on the
other PWM patches ?

Regards,

Hans
