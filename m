Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36056 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730156AbfJVDWs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Oct 2019 23:22:48 -0400
References: <1571631083-4962-1-git-send-email-jeff@labundy.com>
 <1571631083-4962-5-git-send-email-jeff@labundy.com>
 <20191021153825.GA15359@roeck-us.net> <20191022022611.GA2091@labundy.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <f9610e3d-d923-1ffe-233f-e94cace41f64@roeck-us.net>
Date: Mon, 21 Oct 2019 20:22:44 -0700
MIME-Version: 1.0
In-Reply-To: <20191022022611.GA2091@labundy.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH 4/8] hwmon: Add support for Azoteq IQS620AT temperature
 sensor
To: Jeff LaBundy <jeff@labundy.com>
Cc: lee.jones@linaro.org, dmitry.torokhov@gmail.com, jdelvare@suse.com, thierry.reding@gmail.com, jic23@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-hwmon@vger.kernel.org, u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com

On 10/21/19 7:26 PM, Jeff LaBundy wrote:
> Hi Guenter,
> 
> Thank you for your prompt review.
> 
> On Mon, Oct 21, 2019 at 08:38:25AM -0700, Guenter Roeck wrote:
>> On Sun, Oct 20, 2019 at 11:11:19PM -0500, Jeff LaBundy wrote:
>>> This patch adds support for the Azoteq IQS620AT temperature sensor,
>>> capable of reporting its absolute die temperature.
>>>
>>> Signed-off-by: Jeff LaBundy <jeff@labundy.com>
>>
>> Seems to me this might be more feasible as iio driver.
>> Jonathan, what do you think ?
>>
> 
> Interestingly enough, this actually started as an iio driver; however the
> "When to Use" slide of [0] made me suspect that conventional devices with
> the temperature sensing element integrated on the die belong in hwmon.
> 
> I then found the highly similar ad7314, which Jonathan himself appears to
> have converted from iio to hwmon. Therefore, I placed this where existing
> drivers seemed to match the most, especially since the temperature sensors
> in iio generally use IR or a thermocouple.
> 
> That being said, I would be happy to move this into iio so long as Jonathan
> does not mind, as it would limit the blast radius of this patch series.
> 

I don't recall why the ad7314 driver was moved. With a conversion time of 40uS
it is most definitely not a typical use case for a hwmon sensor.

Anyway, not worth arguing about. Just don't complain later. There is an
iio->hwmon bridge, but no hwmon->iio bridge, so the decision does have some
impact. Specifically, userspace will have to implement both hwmon and iio
access to handle the chip.

Guenter
