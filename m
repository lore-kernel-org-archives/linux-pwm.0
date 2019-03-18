Return-Path: <paul.walmsley@sifive.com>
Return-Path: <paul.walmsley@sifive.com>
Subject: Re: [PATCH v9 0/2] PWM support for HiFive Unleashed
References: <1552378289-27245-1-git-send-email-yash.shah@sifive.com>
 <mvmimwotn60.fsf@suse.de>
 <CAJ2_jOE3RH9FyFg_NATcLEpHv5y89zdh06Ji2x8n3C_gp-wn6A@mail.gmail.com>
 <mvm5zsgp00d.fsf@suse.de>
From: Paul Walmsley <paul.walmsley@sifive.com>
Message-ID: <19807892-f450-58d8-2e78-34d3954da56f@sifive.com>
Date: Mon, 18 Mar 2019 16:15:48 -0700
MIME-Version: 1.0
In-Reply-To: <mvm5zsgp00d.fsf@suse.de>
Content-Type: multipart/alternative;
 boundary="------------1DDAA2E043AB5BD9F61CDEA9"
Content-Language: en-US
List-ID: <linux-pwm.vger.kernel.org>
To: Yash Shah <yash.shah@sifive.com>
Cc: Andreas Schwab <schwab@suse.de>, Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>

This is a multi-part message in MIME format.
--------------1DDAA2E043AB5BD9F61CDEA9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi Yash


On 3/18/19 10:26 AM, Andreas Schwab wrote:
> On Mär 15 2019, Yash Shah <yash.shah@sifive.com> wrote:
>
>> You need to make sure the period setting is passed via the
>> conventional way in DT file.
>> Example:
>> pwmleds {
>>     compatible = "pwm-leds";
>>     heartbeat {
>>         pwms = <&L45 0 10000000 0>;
>>         max-brightness = <255>;
>>         linux,default-trigger = "heartbeat";
>>     };
>> };
> I've now managed to build a working FSBL with that change, but that
> didn't change anything.  There is not even a heartbeat option in
> /sys/class/leds/heartbeat/trigger any more.


Could you post a copy of the current DTS file and Kconfig that you're
using so that Andreas can duplicate your results?


thanks,


- Paul


--------------1DDAA2E043AB5BD9F61CDEA9
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Hi Yash</p>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 3/18/19 10:26 AM, Andreas Schwab
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:mvm5zsgp00d.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">On Mär 15 2019, Yash Shah <a class="moz-txt-link-rfc2396E" href="mailto:yash.shah@sifive.com">&lt;yash.shah@sifive.com&gt;</a> wrote:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">You need to make sure the period setting is passed via the
conventional way in DT file.
Example:
pwmleds {
    compatible = "pwm-leds";
    heartbeat {
        pwms = &lt;&amp;L45 0 10000000 0&gt;;
        max-brightness = &lt;255&gt;;
        linux,default-trigger = "heartbeat";
    };
};
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I've now managed to build a working FSBL with that change, but that
didn't change anything.  There is not even a heartbeat option in
/sys/class/leds/heartbeat/trigger any more.
</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Could you post a copy of the current DTS file and Kconfig that
      you're using so that Andreas can duplicate your results?<br>
    </p>
    <p><br>
    </p>
    <p>thanks,</p>
    <p><br>
    </p>
    <p>- Paul<br>
    </p>
  </body>
</html>

--------------1DDAA2E043AB5BD9F61CDEA9--
