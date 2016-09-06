From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v3 1/4] pwm: Add support for Meson PWM Controller
Date: Tue, 6 Sep 2016 11:14:45 +0200
Message-ID: <a43f6e6e-05f6-cefe-451d-528588b85a8c@baylibre.com>
References: <1471880193-21879-1-git-send-email-narmstrong@baylibre.com>
 <1471880193-21879-2-git-send-email-narmstrong@baylibre.com>
 <20160905090052.GG3532@ulmo.ba.sec>
 <bd7ea1db-d8f9-f075-14ef-732d9bb65e77@baylibre.com>
 <20160906090749.GA15644@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160906090749.GA15644@ulmo.ba.sec>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, khilman@baylibre.com, linux-kernel@vger.kernel.org, carlo@caione.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On 09/06/2016 11:07 AM, Thierry Reding wrote:
> On Tue, Sep 06, 2016 at 10:36:49AM +0200, Neil Armstrong wrote:
>> Hi Thierry,
>>
[...]
> 
>>
>> The second bug is in probe(), I understand the point to allocate
>> dynamically the channels and attach them to each pwm chip, but when
>> calling meson_pwm_init_channels() we get an OOPS because
>> meson->chip.pwms[i] are allocated in pwmchip_add(). Moving
>> meson_pwm_init_channels() would fix this, but in case of a clk
>> PROBE_DEFER, we would need to remove back the pwmchip, which is a
>> quite a bad design decision....
> 
> Ah yes... that one again. I remember running into that a while ago with
> some other driver. To be honest, I think that's a short-coming of the
> PWM subsystem and the fix would be for PWM chip registration to be split
> into two parts: pwm_chip_init() and pwm_chip_add(). That way, a chip
> would be initialized using pwm_chip_init() where the pwms array would be
> allocated, and pwm_chip_add() would register the chip with the system.
> 
> Currently a few drivers might be vulnerable to a race condition between
> registration and implementation (i.e. PWM channels aren't fully set up
> when they are exposed to users and sysfs).
> 
>> The smartest fix I found was to allocate channels in probe, init them
>> them attach them after pwmchip_add():
>>
[...]

> 
> That's the race I was talking about above. I suppose it's not too big an
> issue since other drivers seem to manage, so I'm going to merge your
> fixed driver.

ok thanks !

> 
> Unless you feel like taking a stab at the pwm_chip_init()/pwm_chip_add()
> split, in which case your driver would be the first to be race-free. =)

Having he driver upstream is a priority, but having it completely race-free would be great!
I'll be happy to collaborate to a race-free pwmchip probe somehow !

But there is still a glitch, when pwmadd_chip() returns, pwm_get_chip_data(pwm) will still
return crap until meson_pwm_add_channels_data() is called in the following instructions...

The pwm_chip_init()/pwm_chip_add() would be the only solution !

> Thierry
> 

Thanks,
Neil
