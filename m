From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH v9 0/2] PWM support for HiFive Unleashed
Date: Mon, 18 Mar 2019 18:26:10 +0100
Message-ID: <mvm5zsgp00d.fsf@suse.de>
References: <1552378289-27245-1-git-send-email-yash.shah@sifive.com>
        <mvmimwotn60.fsf@suse.de>
        <CAJ2_jOE3RH9FyFg_NATcLEpHv5y89zdh06Ji2x8n3C_gp-wn6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJ2_jOE3RH9FyFg_NATcLEpHv5y89zdh06Ji2x8n3C_gp-wn6A@mail.gmail.com>
        (Yash Shah's message of "Fri, 15 Mar 2019 17:19:59 +0530")
Sender: linux-kernel-owner@vger.kernel.org
To: Yash Shah <yash.shah@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>
List-Id: linux-pwm@vger.kernel.org

On Mär 15 2019, Yash Shah <yash.shah@sifive.com> wrote:

> You need to make sure the period setting is passed via the
> conventional way in DT file.
> Example:
> pwmleds {
>     compatible = "pwm-leds";
>     heartbeat {
>         pwms = <&L45 0 10000000 0>;
>         max-brightness = <255>;
>         linux,default-trigger = "heartbeat";
>     };
> };

I've now managed to build a working FSBL with that change, but that
didn't change anything.  There is not even a heartbeat option in
/sys/class/leds/heartbeat/trigger any more.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
