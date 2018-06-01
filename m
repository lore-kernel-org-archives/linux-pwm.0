From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 1/2] pwm: lpss: platform: Save/restore the ctrl
 register over a suspend/resume
Date: Fri, 1 Jun 2018 15:54:41 +0200
Message-ID: <96e3c95f-479a-f758-b895-890372d71adb@redhat.com>
References: <20180426121024.22023-1-hdegoede@redhat.com>
 <2943907.WSHDcS9sfS@aspire.rjw.lan> <20180514115032.GF18312@ulmo>
 <CAJZ5v0geUBA3g-wr9tHjHH9sCdySAWpOa7BUipKt8_ZspiqS7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0geUBA3g-wr9tHjHH9sCdySAWpOa7BUipKt8_ZspiqS7Q@mail.gmail.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Len Brown <lenb@kernel.org>, Linux PWM List <linux-pwm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Stable <stable@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

Hi Thierry,

Since Rafael has indicated that you can take both
patches upstream with his ack, through the pwm tree:

On 14-05-18 22:36, Rafael J. Wysocki wrote:
> On Mon, May 14, 2018 at 1:50 PM, Thierry Reding
> <thierry.reding@gmail.com> wrote:

<snip>

>> Hans said in the cover letter of the first version of this series that
>> he preferred to merge both patches through the PWM tree because of the
>> dependency. So I'm waiting for an Acked-by from you on the ACPI bits.
> 
> OK, please feel free to add it to the patches, then. >
> Thanks,
> Rafael

So can we get these 2 bugfix patches merged now please ?

Regards,

Hans
