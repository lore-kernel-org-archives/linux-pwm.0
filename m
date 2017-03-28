From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH REGRESSION-FIX resend] pwm: lpss: Set enable-bit before
 waiting for update-bit
Date: Tue, 28 Mar 2017 19:20:11 +0200
Message-ID: <d24997bc-9afc-00ec-425d-92a2d48ec2c6@redhat.com>
References: <20170325140658.26868-1-hdegoede@redhat.com>
 <1490712327.708.30.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:23795 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754410AbdC1RUU (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 28 Mar 2017 13:20:20 -0400
In-Reply-To: <1490712327.708.30.camel@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, "Koskinen, Ilkka" <ilkka.koskinen@intel.com>

Hi,

On 03/28/2017 04:45 PM, Andy Shevchenko wrote:
> On Sat, 2017-03-25 at 15:06 +0100, Hans de Goede wrote:
>> Hi Andy, Thierry,
>>
>> This patch fixes a regression with the pwm-lpss driver in 4.11,
>> where it once turned off will not turn back on again on some
>> machines. Yet it has been silent around this patch for some
>> time now. Can you please review this and get it queued as a fix
>> for 4.11 ?
>
> I have tested this patch (*) on 3 boards:
> 1) internal development board (ApolloLake)
> 2) MinnowBoard MAX (BayTrail)
> 3) Intel Edison / Arduino break out (Tangier)
> 4) ...not yet... (CherryTrail / Braswell)
>
> So, the patch *broke* functionality on 1), while 2) and 3) are survived.

Bummer, so on Apollo Lake we need to set the update bit
*and* wait for it to get acked before setting enable ?

NOte my patch does not change the order of writes, only when we
do the wait.

The only good options I see to fix this is to introduce SoC family
specific code paths :|

If you can whip up a new version which is tested on Apollo Lake
and Bay Trail I can run some tests on Cherry Trail.

Regards,

Hans



>
> (*) The base is my eds branch (https://github.com/andy-shev/linux/tree/e
> ds, v4.11-rc4 based) + few pin control related patches to enable PWM
> output.
>
> P.S. I'll continue looking for CherryTrail / Braswell based board to
> have some coverage there in the future.
>
