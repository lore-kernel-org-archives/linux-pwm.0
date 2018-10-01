From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [RESEND PATCH] Revert "pwm: Set class for exported channels in
 sysfs"
Date: Mon, 1 Oct 2018 15:28:37 +0200
Message-ID: <a6589b2d-c9b3-88a3-f764-e8519db09dbc@st.com>
References: <1537538567-5377-1-git-send-email-fabrice.gasnier@st.com>
 <20180924115301.GV21032@ulmo> <fc02ced1-01ba-dde4-95da-285d9351338b@st.com>
 <20180924142318.GG23547@ulmo> <c4866533-1c7e-2675-5d80-3b824e32ae9b@st.com>
 <4278fef9-ec60-239a-dd0a-29a89d742fa4@st.com> <20180925152022.GB27695@ulmo>
 <CAPoCmY+mNYSV8gq7VCcSJHDpmoq-i7SDJ6uQ5VbLpMZB=b0waQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPoCmY+mNYSV8gq7VCcSJHDpmoq-i7SDJ6uQ5VbLpMZB=b0waQ@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gottfried Haider <gottfried.haider@gmail.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: stefan.wahren@i2se.com, linux-pwm@vger.kernel.org, michal.vokac@ysoft.com, loic.pallardy@st.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, H Hartley Sweeten <hsweeten@visionengravers.com>, broonie@kernel.org, linux-rpi-kernel@lists.infradead.org, gohai@sukzessiv.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On 09/29/2018 02:19 AM, Gottfried Haider wrote:
> Hello Thierry & Fabrice,
> 
>>> Still, it is possible to send uevent (KOBJ_CHANGE) on pwmchipN device,
>>> to notify of a change, e.g. pwmX channel being exported/unexported.
> 
> I tested this patch, and I am happy to report that it works with the
> udev rule that Raspbian (Raspberry Pi's Debian derivative) has in
> place:
> 
> SUBSYSTEM=="pwm*", PROGRAM="/bin/sh -c '\
>         chown -R root:gpio /sys/class/pwm && chmod -R 770 /sys/class/pwm;\
>         chown -R root:gpio
> /sys/devices/platform/soc/*.pwm/pwm/pwmchip* && chmod -R 770
> /sys/devices/platform/soc/*.pwm/pwm/pwmchip*\
> '"
> 
> 
> So while I can't comment on the uevent semantics, it would solve what
> the original patch attempted to enable (non-root use of pwm).
> 
> Tested-by: Gottfried Haider <gottfried.haider@gmail.com>

Hi Gottfried, Thierry,

Thanks for testing. I just sent a new series with:
- revert patch
- additional patch with proposed uevent notification (change) on pwmchip.

Best Regards,
Fabrice

> 
> Best,
> Gottfried
> 
