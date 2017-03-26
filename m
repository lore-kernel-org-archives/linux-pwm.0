From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH REGRESSION-FIX resend] pwm: lpss: Set enable-bit before
 waiting for update-bit
Date: Sun, 26 Mar 2017 16:44:35 +0200
Message-ID: <738f52ef-7c80-bf68-98b5-d7bf3f873360@redhat.com>
References: <20170325140658.26868-1-hdegoede@redhat.com>
 <1490531124.708.1.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38128 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751408AbdCZOoi (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 26 Mar 2017 10:44:38 -0400
In-Reply-To: <1490531124.708.1.camel@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, "Koskinen, Ilkka" <ilkka.koskinen@intel.com>

Hi,

On 26-03-17 14:25, Andy Shevchenko wrote:
> On Sat, 2017-03-25 at 15:06 +0100, Hans de Goede wrote:
>> Hi Andy, Thierry,
>>
>> This patch fixes a regression with the pwm-lpss driver in 4.11,
>> where it once turned off will not turn back on again on some
>> machines. Yet it has been silent around this patch for some
>> time now. Can you please review this and get it queued as a fix
>> for 4.11 ?
>>
>
> Hans, please, give me and Ilkka time to test this. It might appear that
> this fix breaks other platforms and we might need to introduce a quirk
> based on PCI ID. (Hope not)

Ok, thank you for looking into this.

Regards,

Hans
