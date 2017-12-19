From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: pwm: atmel-tcb: Delete an error message for a failed memory
 allocation in atmel_tcb_pwm_probe()
Date: Tue, 19 Dec 2017 18:12:13 +0100
Message-ID: <a40d72aa-a8bd-a9df-358b-cfb368b71e46@users.sourceforge.net>
References: <8274c498-1d1b-2ece-365c-98ded714a53c@users.sourceforge.net>
 <6d607786-4c1b-0949-0768-1bc0a4749fd5@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:60725 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751236AbdLSRMl (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 19 Dec 2017 12:12:41 -0500
In-Reply-To: <6d607786-4c1b-0949-0768-1bc0a4749fd5@microchip.com>
Content-Language: en-GB
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@microchip.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

>> Omit an extra message for a memory allocation failure in this function.
>>
>> This issue was detected by using the Coccinelle software.
> 
> Can you point which coccinelle script highlited this issue?

Not directly (so far).

I constructed an approach for the semantic patch language based on
information from the script “checkpatch.pl”.
Would you like to improve it any ways?

Regards,
Markus
