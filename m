From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH v8 0/2] PWM support for HiFive Unleashed
Date: Tue, 05 Mar 2019 09:32:06 +0100
Message-ID: <mvmlg1tzpq1.fsf@suse.de>
References: <1551437599-29509-1-git-send-email-yash.shah@sifive.com>
        <mvmfts228vu.fsf@suse.de>
        <CAJ2_jOE=8_c6aN2FTQVt0wTpBAkL8BYyF3UFaMmqdvWYWAAmvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJ2_jOE=8_c6aN2FTQVt0wTpBAkL8BYyF3UFaMmqdvWYWAAmvg@mail.gmail.com>
        (Yash Shah's message of "Tue, 5 Mar 2019 13:55:41 +0530")
Sender: linux-kernel-owner@vger.kernel.org
To: Yash Shah <yash.shah@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>
List-Id: linux-pwm@vger.kernel.org

On Mär 05 2019, Yash Shah <yash.shah@sifive.com> wrote:

> On Mon, Mar 4, 2019 at 4:39 PM Andreas Schwab <schwab@suse.de> wrote:
>>
>> On Mär 01 2019, Yash Shah <yash.shah@sifive.com> wrote:
>>
>> > This patch series adds a PWM driver and DT documentation
>> > for HiFive Unleashed board. The patches are mostly based on
>> > Wesley's patch.
>>
>> That doesn't appear to work with the heartbeat trigger, the led doesn't
>> flash.
>
> Make sure you modify the DTS file

Which DTS file?

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
