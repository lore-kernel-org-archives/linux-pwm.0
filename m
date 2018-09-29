From: Gottfried Haider <gottfried.haider@gmail.com>
Subject: Re: [RESEND PATCH] Revert "pwm: Set class for exported channels in sysfs"
Date: Fri, 28 Sep 2018 17:19:18 -0700
Message-ID: <CAPoCmY+mNYSV8gq7VCcSJHDpmoq-i7SDJ6uQ5VbLpMZB=b0waQ@mail.gmail.com>
References: <1537538567-5377-1-git-send-email-fabrice.gasnier@st.com>
 <20180924115301.GV21032@ulmo> <fc02ced1-01ba-dde4-95da-285d9351338b@st.com>
 <20180924142318.GG23547@ulmo> <c4866533-1c7e-2675-5d80-3b824e32ae9b@st.com>
 <4278fef9-ec60-239a-dd0a-29a89d742fa4@st.com> <20180925152022.GB27695@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925152022.GB27695@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: fabrice.gasnier@st.com, stefan.wahren@i2se.com, gohai@sukzessiv.net, H Hartley Sweeten <hsweeten@visionengravers.com>, loic.pallardy@st.com, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pwm@vger.kernel.org, michal.vokac@ysoft.com
List-Id: linux-pwm@vger.kernel.org

Hello Thierry & Fabrice,

>> Still, it is possible to send uevent (KOBJ_CHANGE) on pwmchipN device,
>> to notify of a change, e.g. pwmX channel being exported/unexported.

I tested this patch, and I am happy to report that it works with the
udev rule that Raspbian (Raspberry Pi's Debian derivative) has in
place:

SUBSYSTEM=="pwm*", PROGRAM="/bin/sh -c '\
        chown -R root:gpio /sys/class/pwm && chmod -R 770 /sys/class/pwm;\
        chown -R root:gpio
/sys/devices/platform/soc/*.pwm/pwm/pwmchip* && chmod -R 770
/sys/devices/platform/soc/*.pwm/pwm/pwmchip*\
'"


So while I can't comment on the uevent semantics, it would solve what
the original patch attempted to enable (non-root use of pwm).

Tested-by: Gottfried Haider <gottfried.haider@gmail.com>

Best,
Gottfried
