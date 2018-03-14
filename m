From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 36/47] pwm: remobe pwm-bfin driver
Date: Wed, 14 Mar 2018 17:44:16 +0100
Message-ID: <CAK8P3a3mp=iKq2MvL24wQvhjyhDDeu_ty50vpdcfSnXrSaxjPA@mail.gmail.com>
References: <20180314153603.3127932-1-arnd@arndb.de> <20180314153603.3127932-37-arnd@arndb.de>
 <20180314163808.GA9201@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314163808.GA9201@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Wed, Mar 14, 2018 at 5:38 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Wed, Mar 14, 2018 at 04:35:49PM +0100, Arnd Bergmann wrote:
>> The blackfin architecture is getting removed, so this driver is now
>> obsolete as well.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/pwm/Kconfig    |   9 ---
>>  drivers/pwm/Makefile   |   1 -
>>  drivers/pwm/pwm-bfin.c | 157 -------------------------------------------------
>>  3 files changed, 167 deletions(-)
>>  delete mode 100644 drivers/pwm/pwm-bfin.c
>
> Do you want to apply this in a batch or do you want me to pick it up
> into the PWM tree?
>
> If you want to go for the former:
>
> Acked-by: Thierry Reding <thierry.reding@gmail.com>
>
> Otherwise, just let me know and I'll pick this up for v4.17.

Either way is fine with me, the other maintainers just provided
an Ack, and preferred me to keep the removal in one piece, so
i'll do the same here.

       Arnd
