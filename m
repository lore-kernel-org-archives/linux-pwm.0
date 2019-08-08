Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37418 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbfHHMPA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 8 Aug 2019 08:15:00 -0400
Received: by mail-ed1-f68.google.com with SMTP id w13so90579951eds.4
        for <linux-pwm@vger.kernel.org>; Thu, 08 Aug 2019 05:14:59 -0700 (PDT)
References: <20190730154848.5164-1-hdegoede@redhat.com>
 <31c3f15e-649e-a3c1-56e2-0c35fda24ae1@redhat.com>
 <20190808112122.GB24700@ulmo>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <71bc5280-46e8-77ad-004e-8a9b3befa7d1@redhat.com>
Date: Thu, 8 Aug 2019 14:14:56 +0200
MIME-Version: 1.0
In-Reply-To: <20190808112122.GB24700@ulmo>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH 5.3 regression fix] pwm: Fallback to the static
 lookup-list when acpi_pwm_get fails
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org, youling257@gmail.com, Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>

Hi,

On 08-08-19 13:21, Thierry Reding wrote:
> On Thu, Aug 08, 2019 at 12:19:53PM +0200, Hans de Goede wrote:
>> Thierry,
>>
>> Ping? This fixes a somewhat serious regression in 5.3, can we please get
>> this queued up for merging into 5.3 ?
> 
> I've pushed this out. Let's give it a day in linux-next and then I'll
> send out a PR for v5.3-rc4.

Great, thank you.

Regards,

Hans
