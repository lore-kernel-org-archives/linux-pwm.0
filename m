From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH 2/2] pwm-backlight: switch to gpiod interface
Date: Wed, 7 May 2014 17:39:13 +0900
Message-ID: <CAAVeFuKWoom82aMmPipkeqeAoNfz35bNTOs3deoYeNXZ0jq0cQ@mail.gmail.com>
References: <1393480414-19473-1-git-send-email-acourbot@nvidia.com>
 <1393480414-19473-3-git-send-email-acourbot@nvidia.com> <20140507081850.GB6362@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20140507081850.GB6362@ulmo>
Sender: linux-gpio-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Wed, May 7, 2014 at 5:18 PM, Thierry Reding <thierry.reding@gmail.com> wrote:
> On Thu, Feb 27, 2014 at 02:53:34PM +0900, Alexandre Courbot wrote:
>> Switch to the new gpiod interface, which allows to handle GPIO
>> properties such as active low transparently and removes a whole bunch of
>> code.
>>
>> There are still a couple of users of this driver that rely on passing
>> the enable GPIO number through platform data, so a fallback mechanism
>> using a GPIO number is still available to avoid breaking them. It will
>> be removed once current users have switched to the GPIO lookup tables
>> provided by the gpiod interface.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>  drivers/video/backlight/pwm_bl.c | 72 +++++++++++++++++-----------------------
>>  include/linux/pwm_backlight.h    |  5 +--
>>  2 files changed, 32 insertions(+), 45 deletions(-)
>
> I've applied this with two tiny changes, see below. Please shout if you
> think that's a bad idea.

I'm fine with both changes. Thanks for picking these two guys!

Alex.

>
>> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> [...]
>> @@ -256,8 +238,6 @@ static int pwm_backlight_probe(struct platform_device *pdev)
> [...]
>> +     pb->enable_gpio = devm_gpiod_get(&pdev->dev, "enable");
>> +     if (IS_ERR(pb->enable_gpio)) {
>> +             ret = PTR_ERR(pb->enable_gpio);
>> +             if (ret == -ENOENT) {
>> +                     pb->enable_gpio = NULL;
>> +                     ret = 0;
>> +             } else {
>> +                     goto err_alloc;
>> +             }
>
> I dropped the ret = 0 here because all error paths set it explicitly and
> the non-error path never uses it. Now all branches have a single
> statement and therefore the braces can be dropped.
>
>> +     /*
>> +      * Compatibility fallback for drivers still using the integer GPIO
>> +      * platform data. Must go away soon.
>> +      */
>> +     if (pb->enable_gpio == NULL && gpio_is_valid(data->enable_gpio)) {
>
> Changed the first condition to !pb->enable_gpio for consistency.
>
> Thierry
