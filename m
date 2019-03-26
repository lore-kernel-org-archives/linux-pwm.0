From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH v11 0/2] PWM support for HiFive Unleashed
Date: Tue, 26 Mar 2019 09:44:57 +0100
Message-ID: <mvmva06t46u.fsf@suse.de>
References: <1553508779-9685-1-git-send-email-yash.shah@sifive.com>
        <mvmbm1zueya.fsf@suse.de>
        <CAJ2_jOFuw2uu7Et1cOkKpaEwVofR5nD_v-rkOgFZbACK4BvHhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJ2_jOFuw2uu7Et1cOkKpaEwVofR5nD_v-rkOgFZbACK4BvHhg@mail.gmail.com>
        (Yash Shah's message of "Tue, 26 Mar 2019 12:15:11 +0530")
Sender: linux-kernel-owner@vger.kernel.org
To: Yash Shah <yash.shah@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>
List-Id: linux-pwm@vger.kernel.org

On Mär 26 2019, Yash Shah <yash.shah@sifive.com> wrote:

> 'On Mon, Mar 25, 2019 at 9:24 PM Andreas Schwab <schwab@suse.de> wrote:
>>
>>
>> I still don't see any improvement.  FYI, this is the patch I use for the
>> device tree:
>>
>
> I am sharing you my test environment which has been working for me so
> that you can duplicate at your end

Please test your driver with the DT as above.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
