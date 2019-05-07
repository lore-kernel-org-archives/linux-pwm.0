From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH v11 0/2] PWM support for HiFive Unleashed
Date: Tue, 07 May 2019 18:27:01 +0200
Message-ID: <mvm7eb2qlgq.fsf@suse.de>
References: <1553508779-9685-1-git-send-email-yash.shah@sifive.com>
        <mvmbm1zueya.fsf@suse.de> <mvmpnqcsn6u.fsf@suse.de>
        <CAJ2_jOFu-yCZV_A4B48_fLq7h7UA6LUWhgpxr0uuh7vhW9Q8pA@mail.gmail.com>
        <mvmlfzisiwc.fsf@suse.de>
        <CAJ2_jOG2M03aLBgUOgGjWH9CUxq2aTG97eSX70=UaSbGCMMF_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJ2_jOG2M03aLBgUOgGjWH9CUxq2aTG97eSX70=UaSbGCMMF_g@mail.gmail.com>
        (Yash Shah's message of "Tue, 7 May 2019 16:31:58 +0530")
Sender: linux-kernel-owner@vger.kernel.org
To: Yash Shah <yash.shah@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>
List-Id: linux-pwm@vger.kernel.org

On Mai 07 2019, Yash Shah <yash.shah@sifive.com> wrote:

> Leds on HiFive Unleashed are wired to supply instead of ground.
> And as per ./Documentation/devicetree/bindings/leds/leds-pwm.txt, you
> need to provide additional property "active-low" in such case.
>
> - active-low : (optional) For PWMs where the LED is wired to supply
> rather than ground.

This fixes the issue.

Thanks, Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
