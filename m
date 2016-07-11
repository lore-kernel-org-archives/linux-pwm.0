From: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
Subject: Re: [PATCH v5 2/3] pwm: iproc: Add support for Broadcom iproc pwm controller
Date: Mon, 11 Jul 2016 12:22:38 +0530
Message-ID: <CAL2FKYkH86zhPOrEZQ8Q=WeKUV=2KFfxfA-JTrxiqMnCceQ87g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Russell King <linux@arm.linux.org.uk>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Thierry,

On Fri, Jul 8, 2016 at 8:46 PM, Thierry Reding <thierry.reding@gmail.com> wrote:
> On Tue, Jul 05, 2016 at 02:00:25AM -0400, Yendapally Reddy Dhananjaya Reddy wrote:
>> Add support for the PWM controller present in Broadcom's iProc
>> family of SoCs.It has been tested on the  Northstar+ bcm958625HR board.
>>
>> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
>> ---
>>  drivers/pwm/Kconfig         |  10 ++
>>  drivers/pwm/Makefile        |   1 +
>>  drivers/pwm/pwm-bcm-iproc.c | 268 ++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 279 insertions(+)
>>  create mode 100644 drivers/pwm/pwm-bcm-iproc.c
>
> I've applied this, but I had to make a couple of changes for coding
> style and to squash compiler warnings. Please check the PWM tree's
> for-next branch to see if it still works for you.
>

  Thanks. It is working fine for me. A small change is required here,
NSEC_PER_SEC
instead of USEC_PER_SEC in two places.

Thanks
Dhananjay


> Thierry
